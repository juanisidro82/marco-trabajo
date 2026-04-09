# Selección de Modelo por Capa

## El principio

No todos los LLMs son iguales, y usar el modelo correcto para cada tipo de trabajo
reduce costo y aumenta calidad. La selección correcta es por tipo de tarea, no por proyecto.

```
Haiku  (Ops)   → encuentra el problema  → crea Petición
Sonnet (Dev)   → implementa              → crea Decisión si necesita arquitectura
Opus   (Arch)  → toma la decisión        → genera ADR → Sonnet implementa
```

---

## Las tres capas

### Haiku — Operaciones diarias

**Cuándo usarlo:**
- Tareas rutinarias y predecibles (cobranza, consultas, logística)
- Operaciones que siguen un script bien definido
- Cuando el spec es tan claro que no hay decisiones que tomar
- Para detectar problemas y crear peticiones de desarrollo

**Reglas de operación para Haiku:**
- **SELECT libre** — cualquier lectura se ejecuta sin pedir permiso
- **Writes para revisión** — toda escritura se muestra al usuario ANTES de ejecutar
- **Si no entiende, PREGUNTA** — no asumir ni inventar
- Solo ejecutar a través de scripts y funciones Python bajo commit en el repo
- Si la herramienta que necesita no existe → parar y documentar la necesidad

**Lo que NO hace:**
- No inventa SQL, bash, ni Python one-liners para saltarse herramientas faltantes
- No toma decisiones de diseño
- No modifica `CLAUDE.md` ni estructura de módulos

---

### Sonnet — Desarrollo

**Cuándo usarlo:**
- Implementar una Petición ya definida
- Desarrollo de funciones nuevas con spec claro
- Debugging que requiere razonar sobre el sistema completo
- Tareas que requieren ver múltiples archivos a la vez

**Reglas de operación para Sonnet:**
- Leer los archivos existentes antes de proponer cambios
- Si encuentra una decisión de arquitectura → pausar, crear Decisión para Opus
- Si se traba en una decisión de diseño → escalar a Arch (Opus)
- Consolidar hallazgos al final de cada sesión

**Lo que NO hace:**
- No inventa endpoints ni estructuras sin leer documentación
- No continúa después de un error de infraestructura sin corregir el módulo

---

### Opus — Arquitectura

**Cuándo usarlo:**
- Sonnet se traba en una decisión de diseño
- Revisión semanal: ¿el sistema va en la dirección correcta?
- Diseño de nuevos agentes o módulos antes de construirlos
- Decisiones de infraestructura que afectan múltiples capas
- Post-mortem de incidentes que se repiten (patrón)
- Evaluar si una Petición refleja el problema real o es síntoma de algo más profundo

**Salida esperada:**
- Architecture Decision Record (ADR)
- Plan de implementación para Sonnet
- Criterio de éxito verificable

---

## Bus de comunicación entre capas

Cuando los proyectos usan una herramienta compartida (Anytype, Notion, Linear, etc.):

| Tipo | Creado por | Leído por |
|------|------------|-----------|
| Petición | Haiku (Ops) | Sonnet (Dev) |
| Decisión/ADR | Opus (Arch) | Sonnet (Dev) + Haiku (Ops) |
| Handoff | Cada capa | La misma capa (continuación de sesión) |

Sin herramienta compartida: usar archivos `docs/` como bus de comunicación.

---

## Señal para cambiar de capa

| Situación | Acción |
|-----------|--------|
| La tarea es rutinaria y el spec es claro | Haiku |
| Hay que escribir o modificar código | Sonnet |
| Hay que tomar una decisión que afecta la arquitectura | Opus |
| Sonnet se traba → decisión de diseño | Escalar a Opus |
| Opus decide → implementación clara | Bajar a Sonnet |
| Haiku encuentra bug en producción | Crear Petición → Sonnet |

---

## Principio de diseño para sistemas con IA

> **Reducir fricción ≠ hacerse las cosas fáciles.**
> Antes de proponer algo, la pregunta es: ¿qué fricción específica elimina, y para quién?

### División IA/humano
- **IA maneja:** registro, pagos, cortes, reconexiones, alertas, rutinas predecibles
- **Humanos manejan:** momentos relacionales críticos y decisiones con criterio moral o contextual

Un humano potenciado por IA puede atender 200 clientes con calidad de 50.
