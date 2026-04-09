# Protocolo Blueprint — Handoff Gemini → Claude Code

## Qué es

Un protocolo de traspaso de 7 campos que Gemini CLI (Foreman/Contratista) entrega a
Claude Code (Arquitecto) antes de que Claude toque código complejo.

Su propósito es eliminar la ambigüedad en el handoff: Claude Code recibe información
exacta y verificable, no paráfrasis.

---

## Los 7 campos

### 1. Scope
Archivos, funciones, tablas de BD y líneas exactas que se van a tocar.

```
Scope:
- Archivo: scripts/register_payment.py (líneas 45-78)
- Función: register_payment()
- Tabla BD: renta_residencial (columnas: id_renta, fecha_termino, estado)
```

### 2. Current
Código **verbatim** (copia exacta) del bloque a modificar. Sin paráfrasis, sin resumen.

```python
# Current (líneas 45-52):
def register_payment(service_id: int, amount: float) -> dict:
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO pagos ...")
    return {"status": "ok"}
```

### 3. Target
Diff conceptual: qué entra, qué sale, qué se queda.

```
Target:
ADD: validación de pago duplicado antes del INSERT
ADD: llamada a preview_payment() antes de ejecutar
KEEP: estructura de retorno {"status": "ok"}
REMOVE: conexión directa — usar session_scope() en su lugar
```

### 4. Invariants
Lo que NO se debe tocar bajo ninguna circunstancia.

```
Invariants:
- No cambiar la firma de la función (callers existentes la usan)
- No modificar la tabla "pagos" — solo leer
- No tocar auth.py
```

### 5. Dependencies
Mapa de quién llama a quién (callers/callees) y efectos secundarios conocidos.

```
Dependencies:
- Callers: web/agents/lilandro.py línea 134, scripts/batch_payments.py línea 22
- Callees: get_connection(), preview_payment()
- Efecto secundario: si falla, la transacción queda abierta (ver bug #12)
```

### 6. Business Rules
Reglas de negocio aplicables a este cambio (de `CONTEXT.md` o `CLAUDE.md`).

```
Business Rules:
- Siempre llamar preview_payment() antes de registrar
- Después de registrar: desbloquear router + actualizar comment
- Comment formato: MMDD $tarifa NombreCliente
```

### 7. Verify
Comando exacto de terminal o script para validar que el cambio fue exitoso.

```bash
# Verify:
./venv/bin/python3 scripts/register_payment.py --dry-run --service-id 42
# Resultado esperado: preview sin INSERT, sin error, comment correcto
```

---

## Cuándo es obligatorio

Claude Code **no debe iniciar una tarea compleja** sin recibir un Blueprint completo.
Si falta alguno de los 7 campos, Claude Code devuelve el Blueprint al Foreman (Gemini)
para que lo complete antes de continuar.

**La regla:** si el Blueprint no está completo, el milestone es Infrastructure, no Execution.

---

## Cuándo no es necesario

- Tareas de un solo archivo con cambio obvio y sin callers externos
- Correcciones de typos o mensajes de texto
- Agregar un import o una constante
- Cambios en documentación

**Señal:** si puedes describir el cambio en una oración sin ambigüedad, no necesitas Blueprint.

---

## Construcción orgánica de reglas (patrón relacionado)

Cuando Claude Code detecta un patrón en la operación real que debería convertirse en regla:

1. Claude Code **propone** la regla con justificación
2. El usuario **aprueba o corrige**
3. La regla aprobada va a `CLAUDE.md` o `CONTEXT.md` del proyecto
4. Gemini **valida** qué tan bien está escrita (si Gemini lo entiende, cualquier modelo lo entiende)
5. Las herramientas deterministas que emergen van al módulo principal con commit

> Si Gemini entiende la regla, cualquier modelo la entiende.
> Ese es el criterio de claridad para reglas de negocio escritas en documentos.
