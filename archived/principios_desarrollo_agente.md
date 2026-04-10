# Principios de Desarrollo con Agentes AI

Este documento captura los principios aprendidos en el desarrollo de proyectos con agentes AI.
Está escrito para ser leído por agentes AI al inicio de un proyecto, para alimentar su memoria
y aplicar estos principios desde el primer día.

---

## Principio 1: LLM mínimo — lógica determinista en código

La separación correcta de responsabilidades en un sistema con LLM es:

| Capa | Responsabilidad |
|------|----------------|
| **LLM** | Detectar intención, interpretar lenguaje natural, decidir qué tool llamar |
| **Código (Python/etc.)** | Formatear respuestas, aplicar reglas de negocio, estructurar salidas |

### Señal de alerta
Cuando el system prompt empieza a llenarse de instrucciones de formato, reglas condicionales
o ejemplos de salida — eso indica que esa lógica debe moverse a código.

### Solución validada
Reemplazar instrucciones de formato en el prompt por **plantillas en código**:
el LLM llama el tool, el código toma el resultado y genera la respuesta final.

```
Usuario → LLM (intención) → Tool call → Python (plantilla) → Respuesta
```

### Beneficio
- Respuestas deterministas y consistentes
- El prompt se mantiene corto y enfocado
- El LLM no puede "inventar" formato ni datos

---

## Principio 2: Ciclo de feedback con salidas observables

El mayor acelerador del desarrollo es que el agente de programación pueda
**ver directamente** las salidas del bot, sin depender de que el usuario las describa.

### Implementación
Instrumentar el bot con un transcript automático (ej: `session.log`) que registre:
- Cada consulta del usuario
- Cada respuesta del agente
- Timestamps

### El ciclo
1. Usuario prueba el bot en sesión interactiva
2. Agente de programación lee el log
3. Agente compara la respuesta real contra la esperada
4. Agente identifica la brecha y propone fix
5. Usuario aprueba → commit → siguiente prueba

### Por qué importa
Un desarrollo previo fracasó en 28 días por ciclos de feedback ambiguos:
el usuario describía el problema con palabras, el agente interpretaba diferente,
se generaba algo incorrecto, y el ciclo se repetía sin avanzar.
Con salidas observables, la brecha se vuelve evidente en segundos.

---

## Principio 3: Infraestructura antes de ejecución

Antes de crear o modificar objetos/datos, verificar que se sabe **cómo** hacerlo correctamente.

- Si hay un error de API o DB durante la ejecución → parar, diagnosticar, corregir el cliente.
- No usar workarounds de sesión. Corregir el código base.
- Documentar el hallazgo antes de continuar.

**Tipos de milestone:**
- **Infrastructure Milestone:** el agente no sabe cómo hacer la operación → stop, corregir primero.
- **Execution Milestone:** las herramientas funcionan → ejecutar la tarea.

Si ocurre un error durante ejecución, el milestone cambia a Infrastructure.

---

## Principio 4: Tools con payloads acotados

Los tools registrados en el LLM deben devolver solo los campos necesarios.
Un tool que devuelve miles de objetos completos puede superar el límite de tokens del modelo.

### Reglas
- Filtrar y paginar siempre
- Devolver solo campos que el LLM necesita para razonar
- Nunca registrar como tool una función que devuelva el dataset completo sin filtrar

---

## Principio 5: Estilo de desarrollo del usuario — Exploratory / Opportunistic Programming

El usuario no parte de especificaciones previas. Construye para descubrir qué quiere construir.
Este estilo tiene raíces académicas sólidas y es cognitivamente válido — no es una forma inmadura de programar.

### Paradigmas que lo describen

| Término | Ámbito | Por qué aplica |
|---------|--------|----------------|
| **Exploratory Programming** | Académico (HCI/SE) | El más reconocido formalmente. Sheil (1983): *"creating such programs is more a problem of exploration than implementation"*. |
| **Opportunistic Programming** | Stanford HCI (Brandt et al., 2008) | El más preciso: código impermanente, iteración rápida, objetivo que emerge del proceso. |
| **Bricolage Programming** | Filosofía/educación (Turkle & Papert, 1990) | El programador *conversa con los materiales* en lugar de planificar y ejecutar. |
| **Spike (XP)** | Metodología ágil (Kent Beck) | La única práctica ágil mainstream que formaliza el código descartable como herramienta de descubrimiento. |
| **Reflection-in-Action** | Filosofía de la práctica (Schon, 1983) | Los expertos piensan *mientras hacen*, no antes. |

### Por qué Spec-Driven Development no funciona para este usuario

Spec-Driven asume que el objetivo puede especificarse antes de construir.
Para este usuario, **ver el resultado es parte del proceso de especificarlo**.

### Cómo el agente AI debe adaptarse

1. **No pedir especificaciones completas antes de empezar** — construir algo mínimo y mostrar
2. **Tratar el código inicial como descartable** — no sobre-invertir en arquitectura hasta que el usuario valide la dirección
3. **Ciclos cortos** — construir → mostrar → ajustar, no planificar → aprobar → implementar
4. **El log es el spec** — las correcciones que el usuario hace sobre salidas reales son más precisas que cualquier descripción previa
5. **Refactorizar solo cuando hay dirección confirmada** — no antes

---

## Principio 6: Consolidación de contexto al final de cada sesión

Una vez que algo se entiende y valida, externalizarlo al **repositorio** — no dentro de la
conversación, y no en el sistema de memoria local de Claude (que es máquina-específico).

Formas de consolidación:
- **Script:** si el agente sabe cómo ejecutar un proceso repetible, escribirlo como script
- **Doc:** si se aclaró una regla de negocio o decisión arquitectónica, documentarlo en `docs/`
- **Prompt:** si se desarrolló un prompt reutilizable, guardarlo en `docs/prompts/`
- **Refactor:** si un patrón se repitió en la sesión, consolidarlo en una función reutilizable

El objetivo es que la siguiente sesión — en cualquier máquina, con cualquier LLM — comience
con más contexto en código y docs, y menos reconstruido desde cero.
