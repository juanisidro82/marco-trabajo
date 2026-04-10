# Perfil del Usuario

Este documento debe ser leído por cualquier agente AI al inicio de una sesión de trabajo
con este usuario. Contiene contexto cognitivo y de colaboración que cambia fundamentalmente
cómo debe trabajar el agente.

---

## Perfil cognitivo

El usuario se identifica con **TDAH**, **pensamiento lateral** y perfil **polímata**.

Esto no es una limitación — es el contexto que define cómo colaborar:

- **No puede especificar lo que quiere antes de verlo.** La idea existe pero no de forma
  lineal ni articulable antes de que esté materializada. Especificar requiere sostener una
  imagen mental estática, y eso es precisamente lo que cuesta.
- **La especificación emerge del contacto con el material**, no precede a él. Ver algo
  funcionando (aunque sea incorrecto) le permite decir qué quiere con precisión.
- **Pensamiento lateral:** las conexiones entre ideas son amplias y no secuenciales.
  El usuario puede saltar entre dominios, ver analogías inesperadas, y llegar a
  soluciones por caminos no obvios.

Este perfil corresponde al paradigma académico de **Opportunistic Programming**
(Brandt et al., Stanford HCI, 2008) y **Bricolage** (Turkle & Papert, 1990):
el código como instrumento de pensamiento, no como resultado de un plan.

---

## Cómo debe colaborar el agente AI

### Lo que funciona

- **Construir algo mínimo y mostrarlo** — sin pedir spec previo
- **Inferir la dirección de lo que el usuario corrige**, no de lo que describe
- **Ciclos cortos:** construir → mostrar → ajustar → repetir
- **Salidas observables como canal de comunicación:** logs, transcripts, resultados
  directos — el agente lee la evidencia, no espera descripción verbal del problema
- **Tratar el código inicial como descartable** — no sobre-arquitecturar hasta
  que el usuario valide la dirección

### Lo que no funciona

- Pedir especificaciones completas antes de empezar
- Ciclos largos de "explícame el problema con detalle"
- Asumir que el silencio o la aprobación inicial significa spec cerrado
- Sobre-planificar antes de tener feedback real

---

## Antecedente importante

Un desarrollo anterior fracasó después de **28 días** porque el agente AI
no entendía al usuario. La brecha entre lo que el usuario quería decir y lo que
el agente interpretaba nunca se cerró — los ciclos de feedback eran ambiguos
y verbales, sin evidencia observable.

El ciclo que funciona es:
```
Usuario prueba → agente lee log → agente compara esperado vs real → fix → commit → repetir
```

---

## Estilo de desarrollo

Ver `principios_desarrollo_agente.md` para los principios técnicos completos,
incluyendo la separación LLM/código determinista y el ciclo de feedback observable.
