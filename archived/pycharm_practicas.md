# PyCharm: Prácticas en el Flujo de Trabajo

PyCharm opera como el **Taller**: el lugar donde se revisa y refina lo que produjeron los agentes,
y donde se hacen las ediciones quirúrgicas que requieren precisión, no contexto amplio.

---

## 1. Revisar el output del agente antes del commit

Antes de hacer `git commit`, abrir el diff en PyCharm:

- `Git` → `Show Diff` o `Cmd/Ctrl + D` en el archivo modificado
- Leer cada cambio línea por línea — los agentes suelen introducir:
  - Imports innecesarios
  - Variables renombradas de forma inconsistente
  - Lógica duplicada que ya existía en otro método
  - Type hints incorrectos o faltantes

**Regla:** si el agente tocó más de 3 archivos, revisarlos todos antes de commitear.

---

## 2. Refactoring quirúrgico con herramientas nativas

Cuando un método del agente es bueno pero está mal nombrado, o una clase creció demasiado:

### Renombrar de forma segura
- Click derecho sobre el nombre → `Refactor` → `Rename` (`Shift + F6`)
- PyCharm actualiza automáticamente **todas** las referencias
- Nunca renombrar con find/replace manual — rompe imports y strings

### Extraer método
- Seleccionar un bloque de código dentro de un método largo
- `Refactor` → `Extract` → `Method` (`Cmd/Ctrl + Alt + M`)
- Útil cuando funciones de procesamiento crecen demasiado

### Mover clase a otro archivo
- Click derecho en la clase → `Refactor` → `Move`
- PyCharm actualiza imports automáticamente

---

## 3. Inspección de tipos con Type Hints

Los agentes generalmente omiten type hints. Agregarlos en PyCharm activa validación estática:

```python
# Sin type hints (output típico del agente)
def get_client(self, client_id, include_payments=None):

# Con type hints (revisado en PyCharm)
def get_client(self, client_id: int, include_payments: bool = False) -> dict | None:
```

- `Code` → `Inspect Code` detecta inconsistencias de tipos en todo el archivo
- Los errores de tipo subrayados en rojo son bugs potenciales — no ignorarlos

---

## 4. Debugger para verificar respuestas de API/DB

Cuando un agente produce código que llama a una API o DB pero el resultado es inesperado:

1. Colocar un breakpoint en la línea de `return` dentro de la función de consulta
2. Correr en modo debug (`Shift + F9`)
3. Inspeccionar el resultado directamente en el panel de variables

Esto es más rápido que agregar `print()` y más informativo que leer JSON en el terminal.

---

## 5. Structure View para navegar clases grandes

`View` → `Tool Windows` → `Structure` (`Cmd/Ctrl + 7`)

Muestra todos los métodos de una clase en un panel lateral.
Útil para:
- Ver si un método ya existe antes de pedirle al agente que cree uno nuevo
- Navegar rápidamente entre métodos en archivos con más de 100 líneas

---

## 6. Find Usages antes de cambiar un método

Antes de modificar o eliminar cualquier método:

- Click derecho → `Find Usages` (`Alt + F7`)
- Muestra todos los lugares donde se llama ese método

Evita romper otros módulos al refactorizar.

---

## 7. Local History como red de seguridad

PyCharm guarda un historial local de cada archivo, independiente de git:

- Click derecho en el archivo → `Local History` → `Show History`
- Permite recuperar versiones anteriores aunque no hayas commiteado

Útil cuando un agente sobreescribió algo que funcionaba y ya cerraste la sesión.

---

## 8. JetBrains AI — Cómo usarlo correctamente

JetBrains AI es útil como **sugerencia inline**, no como agente autónomo.

### Sí usar para:
- Completar un método que ya empezaste a escribir
- Explicar un bloque de código que el agente generó y no entiendes
- Sugerir el type hint correcto para un parámetro

### No usar para:
- Pedirle que diseñe un módulo completo
- Pedirle que modifique lógica que toca múltiples archivos
- Reemplazar a Claude Code en decisiones arquitectónicas

**Regla de oro:** si la respuesta del JetBrains AI requiere más de 20 líneas,
la tarea es demasiado grande para el Taller — pasarla al Arquitecto.

---

## 9. Flujo típico de sesión en PyCharm

```
Abrir el archivo modificado por el agente
        ↓
Structure View → verificar que no haya métodos duplicados
        ↓
Inspect Code → revisar errores de tipo y estilo
        ↓
Debugger si hay llamadas a API/DB a verificar
        ↓
Refactoring quirúrgico si es necesario (renombrar, extraer)
        ↓
Git diff final → confirmar que el cambio es exactamente el esperado
        ↓
Commit desde terminal o desde PyCharm
```

---

## Qué nunca delegar a PyCharm

| Tarea | Por qué no |
|-------|------------|
| Diseñar la arquitectura de un módulo | No tiene contexto del proyecto completo |
| Tomar decisiones sobre qué encapsular en OOP | Es decisión del Arquitecto |
| Analizar datasets grandes | No tiene herramientas de análisis de datos |
