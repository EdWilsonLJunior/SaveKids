# Avatar

> **Categoria**: Atom · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Em andamento (iOS parcial, Android pendente) · **Doc Supernova**: Sim

## Contexto
Avatar circular ou rounded square para representar usuário/entidade. Suporta imagem, iniciais (fallback), placeholder e indicador de status (online/offline).

## História de usuário
Como **desenvolvedor**, quero **exibir um avatar com `ZodiakAvatar`** para que **tamanho, forma, fallback e status sigam o DS**.

## Critérios de aceite

### Cenário 1 — Tamanhos
**Dado** Supernova [`Specs - Avatar.md`](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Avatar.md)
**Então** suporta `xs/s/m/l/xl` mapeados para diâmetros `24/32/40/56/72pt` (iOS atual).
> **Gap de spec**: Supernova define apenas `small (48×48px)` e `medium (64×64px)`. A implementação iOS expande para 5 tamanhos — alinhamento pendente com Design.

### Cenário 2 — Fallbacks
**Dado** sem `image`
**Então** mostra iniciais (`John Doe` → "JD"); sem iniciais, mostra ícone de pessoa.

### Cenário 3 — Status
**Dado** `status: .online`
**Então** dot verde (`statusOnline`) no canto inferior direito com ring `surface`.

**Dado** `status: .away`
**Então** dot vermelho médio (`statusAway` = Red.shade400).

**Dado** `status: .doNotDisturb`
**Então** dot vermelho escuro (`statusDoNotDisturb` = `textNegative`, adaptive).

**Dado** `status: .offline`
**Então** dot cinza neutro (`statusOffline` = Neutral.shade400).

> **Nota de implementação**: tokens são fill de dot indicator. Spec Supernova documenta também cores de badge (bg + text + ring) para UI futura mais rica.

### Cenário 4 — Acessibilidade
**Dado** avatar de João
**Então** VoiceOver/TalkBack anuncia "João" (ou "Avatar de João" se papel `image`).

### Cenário 5 — Loading
**Dado** imagem ainda carregando
**Então** mostra skeleton circular; sem flicker.

## Spec técnica

### APIs públicas
```
ZodiakAvatar(
  initials: String? = none,
  systemImage: String? = none,
  size: ZodiakAvatarSize = .m,         // xs | s | m | l | xl
  status: ZodiakAvatarStatus? = none,  // online | away | doNotDisturb | offline
  backgroundColor: Color? = none       // sobrepõe cor de fundo padrão
)
```

> **Gap**: sem parâmetro `name: String` — iniciais são passadas já formatadas. Sem carregamento assíncrono de imagem (AsyncImage) na implementação atual. Sem `shape` (sempre círculo).

### Tokens

**Iniciais — cores de fundo predefinidas** (passadas via `backgroundColor`):

| Token | Hex |
|---|---|
| `surfaceInk` | `#121a38` (Surface Ink Heavy) |
| `surfaceMarine` | `#1c4076` (Surface Marine Heavy) |
| `surfaceAzur` | `#0058ab` (Surface Azur Heavy) |

**Texto sobre iniciais**: `textAlwaysWhite`.

**Avatar brand — Logo Spade**:

| Elemento | Token |
|---|---|
| Fundo | Blue 500 = `#0058ab` |
| Spade | `textAlwaysWhite` |

**Status — dot fill** (ver `ZodiakColors`):

| Status | Token | Hex (light) |
|---|---|---|
| `.online` | `statusOnline` = `textPositive` | `#21b87d` |
| `.away` | `statusAway` = `Red.shade400` | `#ff6270` |
| `.doNotDisturb` | `statusDoNotDisturb` = `textNegative` | `#9e0029` / `#ffa7a9` dark |
| `.offline` | `statusOffline` = `Neutral.shade400` | `#a6acb5` |

**Cores de estado (interacção)**:

| Estado | Elemento | Token |
|---|---|---|
| Hover | Overlay | `Overlay.black15` (`rgba(0,0,0,0.15)`) |
| Hover | Ação | `actionPrimaryOnPhoto` |
| Focus | Ring | `actionFocusOnLite` (`#2e323a` light / `#ffffff` dark) |

**Ring/separator de status**: `surface` (= `pageBackground`).

## Boas práticas — iOS
- **Assinatura concreta**: `ZodiakAvatar(name: String, image: Image? = none, size: ZodiakSize = .md, shape: ZodiakAvatarShape = .circle, status: ZodiakAvatarStatus? = none)`.

- SwiftUI: `AsyncImage(url:)` para carregar URL. `Image(...).resizable().clipShape(Circle())`.
- HIG: [Images and graphics](https://developer.apple.com/design/human-interface-guidelines/images).

## Boas práticas — Android
- **Assinatura concreta**: composable equivalente com `painter: Painter? = null` ou URL via Coil.

- Compose + Coil: `AsyncImage(model = url, contentDescription = ...)` com `Modifier.clip(CircleShape)`.
- Para shimmer: `Modifier.placeholder(visible = isLoading, ...)` ou `Modifier.shimmer()`.

## Acessibilidade
- `accessibilityLabel`/`contentDescription` = nome do usuário.
- Status (online) anunciado como parte do label ("João, online").
- Decorativo em listas onde o nome já aparece ao lado → `accessibilityHidden`.

## Referências
- [iOS `Atoms/Avatar/ZodiakAvatar.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Atoms/Avatar/ZodiakAvatar.swift)
- [Supernova: Overview](../../ZodiakiOS/docs/zodiak-pdf/Overview%20-%20Avatar.md)
- [Supernova: Specs](../../ZodiakiOS/docs/zodiak-pdf/Specs%20-%20Avatar.md)

## Gaps & dúvidas para o time de Design
- [ ] **Gap de sizing**: Supernova define `small (48px)` e `medium (64px)`; iOS implementa 5 tamanhos (`xs` 24pt a `xl` 72pt). Qual é o contrato correto?
- [ ] **Iniciais: mapping nome → cor** — algoritmo de hash para selecionar entre `surfaceInk`/`surfaceMarine`/`surfaceAzur` — oficializado?
- [ ] **Carregamento assíncrono** — `AsyncImage(url:)` não implementado; apenas iniciais e `systemImage` são suportados atualmente.
- [ ] **Formato `rounded-square`** — variante `shape: .roundedSquare` não implementada (sempre círculo).
- [ ] **`statusAway` família vermelha** — Zodiak define Away com Surface Negative (vermelho), divergindo de convenções UX comuns (âmbar). Confirmar com Design.
- [ ] **`surfaceCloudLite`** — token de badge-bg do status Offline (`#eff0f4` light / `#21252d` dark) não existe como colorset. Necessário se badge UI futura for implementada.

## DoD
- [x] Tokens de status definidos e alinhados com spec (`statusOnline`, `statusAway`, `statusDoNotDisturb`, `statusOffline`).
- [x] `ZodiakAvatar` remove dependência de `UIColor.systemGray3` — usa `statusOffline`.
- [x] Docs Supernova reformatadas (`Overview - Avatar.md`, `Specs - Avatar.md`) com tabelas completas.
- [ ] Carregamento assíncrono de imagem implementado.
- [ ] `ZodiakAvatarGroup` testada e documentada.
- [ ] Implementação Android.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

### Importação
```tsx
import { Avatar } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'photo' \| 'initials' \| 'brand'` | `'initials'` | Conteúdo exibido |
| `size` | `'xsmall' \| 'small' \| 'medium' \| 'large'` | `'medium'` | Tamanho |
| `src` | `string` | — | URL da imagem (variant="photo") |
| `initials` | `string` | — | 1–2 caracteres (variant="initials") |
| `status` | `'active' \| 'away' \| 'inactive' \| 'offline'` | — | Badge de presença |
| `alt` | `string` | — | Texto alternativo acessível |
| `actionable` | `boolean` | `false` | Torna o avatar focalizável via teclado |

### Acessibilidade
- Sempre forneça `alt` descritivo para variante `photo`; para variantes decorativas, use `alt=""`.
- Use `actionable={true}` apenas quando o avatar for clicável.

### Storybook
- `AllOptions`: grade de todas as variantes × tamanhos × status
- `Playground`: controles interativos
