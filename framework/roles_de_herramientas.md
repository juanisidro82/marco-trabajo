# Roles de Herramientas en el Flujo de Trabajo

## Visión general

Cada herramienta tiene un rol fijo basado en sus capacidades reales, no en preferencias.
Usar la herramienta equivocada para un tipo de trabajo es la causa principal de sesiones fallidas.

```
Claude Code   →  Arquitecto    →  Diseña, decide, estructura
Gemini CLI    →  Contratista   →  Ejecuta planes largos con contexto completo
PyCharm       →  Taller        →  Edición quirúrgica, revisión de calidad
```

---

## Claude Code — Arquitecto

### Cuándo usarlo
- Diseñar un nuevo módulo o script
- Tomar decisiones de trade-off ("¿OOP o procedural?", "¿un módulo o dos?")
- Escribir o actualizar `CLAUDE.md` y `docs/`
- Debuggear un error que requiere razonar sobre el sistema completo
- Definir el protocolo para una sesión futura

### Cómo iniciar una sesión
1. No describir la tarea de inmediato — primero dar contexto:
   - Estado actual del proyecto
   - Qué falló en la sesión anterior (si aplica)
   - Qué tipo de milestone es: Infrastructure o Execution
2. Luego describir la tarea específica
3. Pedir un plan antes de ejecutar si la tarea toca más de un archivo

### Reglas de operación
- Si da un error de API/DB → parar, corregir el módulo, no buscar workaround
- Si la sesión supera 15-20 intercambios → consolidar y cerrar, no seguir acumulando
- Cada descubrimiento se documenta antes de cerrar la sesión

### Nunca hacer
- Pedirle ejecutar tareas repetitivas largas
- Dejar que invente endpoints o estructuras de DB sin leer documentación primero
- Continuar una sesión después de un error sin corregir el módulo

---

## Gemini CLI — Contratista

### Cuándo usarlo
- Ejecutar un plan ya diseñado por Claude Code
- Refactorizaciones que requieren ver muchos archivos a la vez
- Sesiones largas del mismo tipo de trabajo (crear lotes, analizar CSVs)
- Cuando la cuota de Claude Code se agota y la tarea es ejecución

### Cómo iniciar una sesión
1. Dar contexto completo de una vez: pegar `CLAUDE.md` + el plan de la tarea
2. Pedir que lea los archivos relevantes antes de actuar
3. Establecer el milestone desde el inicio: "esto es ejecución, la infraestructura ya está lista"

### Reglas de operación
- Aprovechar el contexto grande: cargar snapshots, módulos principales y docs juntos
- Usar roadmaps explícitos: pedirle que genere el plan y aprobarlo antes de ejecutar
- Para lotes grandes: ejecutar en bloques verificables

### Nunca hacer
- Pedirle decisiones arquitectónicas
- Dejar que modifique `CLAUDE.md` o la estructura de módulos sin revisión
- Usar para tareas que requieren juicio sobre calidad de código

---

## PyCharm — Taller

### Cuándo usarlo
- Editar un método específico dentro de un archivo existente
- Revisar calidad de código: tipos, nombres, estructura de clases
- Refactoring quirúrgico: renombrar, extraer método, mover clase
- Revisar el output del agente antes de hacer commit

### Reglas de operación
- Es el punto de revisión antes del commit — todo código generado por agentes pasa por aquí
- No delegar decisiones de diseño al asistente inline de JetBrains
- Útil para mantener type hints y docstrings que los agentes suelen omitir

### Nunca hacer
- Usarlo para tareas que requieren contexto del proyecto completo
- Reemplazar a Claude Code en decisiones arquitectónicas

---

## Protocolo de traspaso entre herramientas

```
Claude Code diseña y documenta
        ↓
Gemini CLI ejecuta el plan
        ↓
PyCharm revisa el resultado
        ↓
Commit
        ↓
Claude Code actualiza docs si hubo hallazgos
```

### Señal para cambiar de herramienta

| Situación | Acción |
|-----------|--------|
| La tarea requiere ver más de 5 archivos a la vez | Cambiar a Gemini CLI |
| La tarea es repetitiva y el spec es claro | Cambiar a Gemini CLI o script |
| Hay que tomar una decisión de diseño | Cambiar a Claude Code |
| Un método específico necesita edición cuidadosa | Cambiar a PyCharm |
| La cuota de Claude se agota y es ejecución | Continuar con Gemini CLI |
| La cuota de Claude se agota y es arquitectura | Esperar o usar PyCharm como taller |

---

## Regla general

> Si tienes que explicarle el contexto al agente, es trabajo de Arquitecto o Contratista.
> Si el agente solo necesita ejecutar un comando ya definido, es trabajo de Mason.
>
> El objetivo del proyecto es convertir la mayor cantidad de trabajo posible en trabajo de Mason,
> encapsulando lógica en módulos Python que cualquier herramienta puede invocar sin entender el sistema.

---

## Decisión de stack: por qué solo tres herramientas

La triada **PyCharm + Claude Code + Gemini CLI** es una decisión deliberada, no un default.
Cubre los tres tipos de trabajo sin solapamiento:

```
Claude Code  →  decisión
Gemini CLI   →  ejecución con contexto completo
PyCharm      →  precisión quirúrgica
```

Cada herramienta adicional requiere:
- Su propio archivo de contexto sincronizado con el proyecto
- Aprender sus comportamientos y límites específicos
- Mantener coherencia entre sus instrucciones y las de los otros agentes

Tres herramientas con roles claros superan a cinco herramientas con roles solapados.

**Si se evalúa agregar una herramienta en el futuro, la pregunta es:**
¿Cubre un tipo de trabajo que ninguna de las tres actuales puede hacer?
Si la respuesta es no, no se agrega.
