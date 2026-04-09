# Vibe Coding Profesional

## Qué es vibe coding

Término acuñado por Andrej Karpathy (ex-OpenAI) en 2025 para describir programar **por intención**,
dejando que el LLM genere la implementación.

| Programación tradicional | Vibe Coding |
|--------------------------|-------------|
| Determinista: escribes exactamente lo que corre | Probabilístico: describes lo que quieres |
| El fallo viene del programador | El fallo viene de contexto incompleto |
| El conocimiento vive en tu cabeza | El conocimiento debe vivir en archivos |
| Debuggeas código | Debuggeas contexto |

---

## La analogía Six Sigma

Six Sigma reduce defectos controlando variables del proceso. En vibe coding, el "proceso" es:

```
Contexto disponible → LLM razona → genera código → verificas
```

Las variables que generan defectos son:

- **Contexto incompleto** → API inventada, endpoint incorrecto, tabla DB desconocida
- **Especificación ambigua** → El agente adivina, tú corriges
- **Sin verificación** → El error llega tarde, cuesta más
- **Conocimiento en el chat** → Se pierde al cerrar la sesión

`CLAUDE.md`, módulos Python encapsulados, y el protocolo de inicio de sesión son **controles de proceso**
— equivalentes a un plan de control Six Sigma.

---

## Prácticas profesionales

### 1. Spec-first
Escribir lo que el código debe hacer **antes** de pedirle al agente que lo escriba.

- Malo: *"registra el pago"*
- Bueno: *"registra el pago del cliente X por el monto Y, verifica que no exista uno duplicado el mismo día, actualiza el estado del router si corresponde"*

La especificación precisa reduce la varianza del output.

### 2. Verification-driven Development
Análogo a TDD pero para agentes: antes de ejecutar, definir cómo verificarás que el resultado es correcto.

- Ejemplo: después de `register_payment()`, verificar con una query a la DB o leyendo el log.
- Sin verificación, el agente asume éxito y construye sobre una base potencialmente rota.

### 3. Context Engineering
Decidir conscientemente qué vive en cada capa:

| Capa | Qué va aquí |
|------|-------------|
| `CLAUDE.md` | Protocolo de sesión, reglas obligatorias, dominio del proyecto |
| `docs/` | Hallazgos técnicos, errores conocidos, decisiones validadas |
| Código Python | Lógica encapsulada, IDs validados, heurísticas |
| Prompt de sesión | Tarea específica del día |

Mover conocimiento de MD a funciones Python reduce la carga cognitiva del agente
y elimina el riesgo de interpretación incorrecta.

### 4. Infraestructura antes de ejecución
Distinguir entre dos tipos de milestone:

- **Infrastructure Milestone:** el agente no sabe cómo hacer la operación → parar, corregir el módulo, documentar.
- **Execution Milestone:** las herramientas funcionan → crear, modificar, ejecutar.

Si ocurre un error durante ejecución, el milestone cambia a Infrastructure. No usar workarounds de sesión.

### 5. Consolidación inmediata
Cuando algo funciona, no avanzar. Primero:

1. Actualizar la función correspondiente en el módulo Python.
2. Documentar el hallazgo en el archivo de docs relevante.
3. Commit.

El conocimiento que no se consolida muere cuando se cierra la sesión.

---

## Distinción clave: Vibe Coder vs. Profesional

> El vibe coder confía en el modelo.
> El profesional **diseña el sistema en el que el modelo opera**.

La diferencia es la misma que entre un operador usando una máquina y un ingeniero de procesos
diseñando cómo esa máquina debe usarse para minimizar defectos.

---

## Señales de madurez en un proyecto de vibe coding

- [ ] El agente puede iniciar una nueva sesión sin preguntas, solo leyendo los archivos del proyecto.
- [ ] Los errores conocidos no se repiten entre sesiones.
- [ ] El conocimiento vive en código ejecutable, no en conversaciones.
- [ ] Hay distinción clara entre milestones de infraestructura y ejecución.
- [ ] Hay verificación automática o manual después de cada acción crítica.

---

## Fuentes para estudiar

| Fuente | Qué aporta |
|--------|------------|
| Simon Willison — simonwillison.net | El escritor más riguroso sobre prácticas LLM en desarrollo |
| Andrej Karpathy — X / YouTube | Inventor del término, perspectiva técnica profunda |
| "Building with LLMs" — Eugene Yan | Patrones de sistemas LLM en producción |
| Prompt Engineering Guide — promptingguide.ai | Base técnica de cómo funciona el contexto |
