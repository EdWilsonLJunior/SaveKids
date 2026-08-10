#!/usr/bin/env python3
"""
Adiciona seção "Boas práticas — React/Web" a cada arquivo de backlog do DS.
"""

import os

BASE = "/Users/mrocha/Developer/Zodiak/docs/backlog"

# ──────────────────────────────────────────────────────────────────────────────
# Seção de gap (componente ainda não portado para React)
# ──────────────────────────────────────────────────────────────────────────────
GAP = """
## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
"""

# ──────────────────────────────────────────────────────────────────────────────
# Seção de token (foundation disponível via CSS Custom Properties)
# ──────────────────────────────────────────────────────────────────────────────
def token_section(token_prefix: str, example_var: str, note: str = "") -> str:
    extra = f"\n{note}\n" if note else ""
    return f"""
## Boas práticas — React/Web

### Disponibilidade
Tokens disponibilizados como **CSS Custom Properties** via `ThemeProvider`. Não há componente React dedicado — os valores são resolvidos automaticamente pela classe de tema no elemento raiz.{extra}

### Uso
```tsx
import {{ ThemeProvider }} from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light">
  {{/* {example_var} fica disponível em todo o subárvore */}}
  <div style={{{{ {token_prefix}: 'var({example_var})' }}}} />
</ThemeProvider>
```

### Acessibilidade
- Use sempre tokens semânticos (ex.: `--zodiak-action-primary-default`) em vez de valores primitivos ou hardcoded.
"""

# ──────────────────────────────────────────────────────────────────────────────
# Seções completas por arquivo
# ──────────────────────────────────────────────────────────────────────────────
SECTIONS = {

    # ── 00-foundations ─────────────────────────────────────────────────────

    "00-foundations/aspect-ratios.md": token_section(
        "aspect-ratio", "--zodiak-aspect-ratio-video",
        "> **Nota:** O prefixo exato depende da versão do tema; verifique `tokens.css` do pacote."
    ),

    "00-foundations/blurs.md": token_section(
        "backdrop-filter", "--zodiak-blur-md"
    ),

    "00-foundations/borders.md": token_section(
        "border", "--zodiak-border-primary"
    ),

    "00-foundations/colors.md": """
## Boas práticas — React/Web

### Disponibilidade
Tokens de cor expostos como **CSS Custom Properties** via `ThemeProvider`. A classe `.zodiak-theme-light` ou `.zodiak-theme-dark` no elemento raiz resolve automaticamente os valores semânticos.

### Uso
```tsx
import { ThemeProvider } from '@cg-groupit/zodiak-design-system';

<ThemeProvider defaultTheme="light" storageKey="zodiak-theme">
  <App />
</ThemeProvider>
```

```css
/* Em qualquer folha CSS sob o ThemeProvider: */
.meu-componente {
  color:      var(--zodiak-text-primary);
  background: var(--zodiak-surface-background);
  border:     1px solid var(--zodiak-border-primary);
}
```

### Props principais — ThemeProvider
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `defaultTheme` | `'light' \\| 'dark'` | sistema | Tema inicial |
| `storageKey` | `string` | — | Chave localStorage para persistência |

### Acessibilidade
- Contraste mínimo: ≥ 4.5:1 para texto, ≥ 3:1 para UI.
- Nunca use primitivos hexadecimais em produção; use tokens semânticos.

### Storybook
- `AllOptions`: grade de todas as variantes de tema
- `Playground`: alternância light/dark interativa
""",

    "00-foundations/defaults.md": token_section(
        "box-sizing", "--zodiak-default-border-box",
        "> **Nota:** Defaults como `box-sizing: border-box` e `font-family` são aplicados globalmente pelo `ThemeProvider`."
    ),

    "00-foundations/flags.md": GAP,

    "00-foundations/gradients.md": token_section(
        "background", "--zodiak-gradient-hero"
    ),

    "00-foundations/grid.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ZodiakLayout, ZodiakSection } from '@cg-groupit/zodiak-design-system';
```

### Props principais — ZodiakLayout
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `children` | `ReactNode` | — | Conteúdo da grade |
| `className` | `string` | — | Classe extra |

### Props principais — ZodiakSection
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `children` | `ReactNode` | — | Conteúdo da seção |
| `background` | `string` | `'page'` | Contexto de superfície |
| `className` | `string` | — | Classe extra |

### Acessibilidade
- `ZodiakSection` renderiza um `<section>` semântico; inclua um heading ou `aria-label` descritivo.

### Storybook
- `AllOptions`: exemplos de layouts de grade em breakpoints
- `Playground`: controles interativos de colunas e espaçamento
""",

    "00-foundations/hit-target.md": GAP,

    "00-foundations/icons.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Icon, ArrowRightIcon } from '@cg-groupit/zodiak-design-system';
```

### Props principais — Icon
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `Component` | `React.ComponentType` | — | Componente SVG do ícone (obrigatório) |
| `size` | `'small' \\| 'medium' \\| 'large' \\| 'xlarge'` | `'small'` | Tamanho (16/24/32/56 px) |
| `decorative` | `boolean` | `true` | Se `true`, aplica `aria-hidden`; se `false`, exige `aria-label` |
| `className` | `string` | — | Classe extra |

### Acessibilidade
- Ícones decorativos: `decorative={true}` (padrão) → `aria-hidden="true"`.
- Ícones informativos: `decorative={false}` + `aria-label="Descrição do ícone"`.

### Storybook
- `AllOptions`: grade de todos os ícones disponíveis por categoria
- `Playground`: controles de tamanho e cor
""",

    "00-foundations/logo.md": GAP,

    "00-foundations/motion.md": token_section(
        "transition", "--zodiak-motion-duration-fast",
        "> **Nota:** Use `prefers-reduced-motion` para desabilitar animações quando o usuário solicitar."
    ),

    "00-foundations/opacity.md": token_section(
        "opacity", "--zodiak-opacity-disabled"
    ),

    "00-foundations/radii.md": token_section(
        "border-radius", "--zodiak-radius-md"
    ),

    "00-foundations/shadows.md": token_section(
        "box-shadow", "--zodiak-shadow-md"
    ),

    "00-foundations/sizing.md": token_section(
        "height", "--zodiak-sizing-button-height-md"
    ),

    "00-foundations/spacing.md": token_section(
        "padding", "--zodiak-spacing-16",
        "> **Nota:** Use múltiplos de 4 px via tokens `--zodiak-spacing-4`, `--zodiak-spacing-8`, `--zodiak-spacing-16`, etc."
    ),

    "00-foundations/typography.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Typography } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `type` | `'heading' \\| 'body'` | — | Família tipográfica (obrigatório) |
| `size` | `HeadingSize \\| BodySize` | — | Escala: Heading `6XL`…`2XS`; Body `XL`…`XS` |
| `weight` | `300 \\| 400 \\| 500` | `300` | Peso (apenas para `type="heading"`) |
| `as` | `React.ElementType` | `'span'`/`'p'` | Elemento HTML semântico a renderizar |

### Acessibilidade
- Sempre defina `as` com o elemento HTML correto na hierarquia da página (`h1`…`h6`, `p`, `span`).
- Nunca use `Typography` para decorar elementos interativos — prefira `ButtonRegular` ou `Link`.

### Storybook
- `AllOptions`: grade de todos os estilos de heading e body em light/dark
- `Playground`: controles interativos de `type`, `size`, `weight` e `as`
""",

    # ── 01-theme ────────────────────────────────────────────────────────────

    "01-theme/zodiak-theme.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ThemeProvider, useZodiakTheme } from '@cg-groupit/zodiak-design-system';
```

### Props principais — ThemeProvider
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `defaultTheme` | `'light' \\| 'dark'` | preferência do sistema | Tema inicial |
| `storageKey` | `string` | — | Chave localStorage para persistir a escolha |
| `className` | `string` | — | Classe extra no elemento wrapper |
| `children` | `ReactNode` | — | Subárvore que receberá o tema |

### Uso com hook
```tsx
const { theme, setTheme } = useZodiakTheme();
// theme: 'light' | 'dark'
// setTheme('dark') — persiste se storageKey foi configurado
```

### Acessibilidade
- O `ThemeProvider` aplica a classe `.zodiak-theme-light` ou `.zodiak-theme-dark` no wrapper, resolvendo todos os tokens CSS automaticamente.
- Respeite `prefers-color-scheme` omitindo `defaultTheme` — o provider usa a preferência do sistema como padrão.

### Storybook
- `AllOptions`: demonstração de alternância light/dark com todos os tokens
- `Playground`: controles interativos de tema com persistência
""",

    # ── 02-atoms ────────────────────────────────────────────────────────────

    "02-atoms/avatar.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Avatar } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'photo' \\| 'initials' \\| 'brand'` | `'initials'` | Conteúdo exibido |
| `size` | `'xsmall' \\| 'small' \\| 'medium' \\| 'large'` | `'medium'` | Tamanho |
| `src` | `string` | — | URL da imagem (variant="photo") |
| `initials` | `string` | — | 1–2 caracteres (variant="initials") |
| `status` | `'active' \\| 'away' \\| 'inactive' \\| 'offline'` | — | Badge de presença |
| `alt` | `string` | — | Texto alternativo acessível |
| `actionable` | `boolean` | `false` | Torna o avatar focalizável via teclado |

### Acessibilidade
- Sempre forneça `alt` descritivo para variante `photo`; para variantes decorativas, use `alt=""`.
- Use `actionable={true}` apenas quando o avatar for clicável.

### Storybook
- `AllOptions`: grade de todas as variantes × tamanhos × status
- `Playground`: controles interativos
""",

    "02-atoms/badge.md": GAP,

    "02-atoms/breadcrumb-pagination.md": GAP,

    "02-atoms/button-arrow.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonArrow } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `ariaLabel` | `string` | — | Rótulo acessível (obrigatório) |
| `size` | `'small' \\| 'medium' \\| 'large' \\| 'xlarge'` | `'large'` | Tamanho |
| `background` | `'onLite' \\| 'onHeavy' \\| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `onClick` | `MouseEventHandler` | — | Handler de clique |

### Acessibilidade
- `ariaLabel` é obrigatório — o botão não exibe texto visível.
- O atributo `aria-label` (kebab-case) está bloqueado; use apenas `ariaLabel`.

### Storybook
- `AllOptions`: grade de tamanhos × superfícies
- `Playground`: controles interativos
""",

    "02-atoms/button-filter.md": GAP,

    "02-atoms/button-icon.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonIcon, ArrowRightIcon } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `icon` | `React.ComponentType` | — | Componente ícone (obrigatório) |
| `ariaLabel` | `string` | — | Rótulo acessível (obrigatório) |
| `size` | `'small' \\| 'medium' \\| 'large'` | `'medium'` | Tamanho |
| `hierarchy` | `'primary' \\| 'secondary' \\| 'tertiary'` | `'primary'` | Hierarquia visual |
| `background` | `'onLite' \\| 'onHeavy' \\| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- `ariaLabel` é obrigatório — não há texto visível.
- Use `url` para renderizar como `<a>` em vez de `<button>`.

### Storybook
- `AllOptions`: grade de ícones × hierarquias × superfícies
- `Playground`: controles interativos
""",

    "02-atoms/button-media.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonVideoPreview } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'play' \\| 'volume'` | `'play'` | Comportamento do botão |
| `isPlaying` | `boolean` | `false` | Estado atual de reprodução |
| `progress` | `number` | — | Progresso 0–1 para o anel circular |
| `showRing` | `boolean` | `false` | Exibe anel de progresso (variant="play") |
| `background` | `'onLite' \\| 'onHeavy' \\| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `size` | `'mobile' \\| 'desktop' \\| 'desktopSmallTablet'` | `'desktop'` | Tamanho responsivo |

### Acessibilidade
- `aria-label` é gerado automaticamente com base em `isPlaying`/`isMuted`; sobrescreva com `ariaLabel` se necessário.

### Storybook
- `AllOptions`: variantes play/volume × superfícies × tamanhos
- `Playground`: controles interativos com simulação de progresso
""",

    "02-atoms/button-menu.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonMenu } from '@cg-groupit/zodiak-design-system';
import type { ButtonMenuOption } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | `'Make a choice'` | Texto do botão gatilho |
| `options` | `ButtonMenuOption[]` | — | Itens do menu (obrigatório) |
| `size` | `'small' \\| 'medium'` | `'medium'` | Tamanho do gatilho |
| `hierarchy` | `'primary' \\| 'secondary' \\| 'tertiary'` | `'primary'` | Hierarquia visual |
| `onSelect` | `(value: string) => void` | — | Callback de seleção |

### Acessibilidade
- O menu usa padrão ARIA `role="menu"` + `role="menuitem"` com navegação por seta do teclado.
- Fecha ao pressionar `Escape` ou clicar fora.

### Storybook
- `AllOptions`: exemplos de menus com diferentes hierarquias e tamanhos
- `Playground`: controles interativos com opções configuráveis
""",

    "02-atoms/button-nav.md": GAP,

    "02-atoms/button-regular.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonRegular } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto do botão |
| `hierarchy` | `'primary' \\| 'secondary' \\| 'tertiary'` | `'primary'` | Hierarquia visual |
| `size` | `'small' \\| 'medium' \\| 'large'` | `'medium'` | Tamanho |
| `background` | `'onLite' \\| 'onHeavy' \\| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `isWarning` | `boolean` | `false` | Aplica tratamento visual de aviso |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `url` | `string` | — | Renderiza como `<a>` quando fornecido |
| `fullWidth` | `boolean` | `false` | Ocupa toda a largura do contêiner |

### Acessibilidade
- Use `aria-label` para botões cujo texto visível não é descritivo o suficiente.
- `disabled` desabilita interação e anúncio via screen reader.

### Storybook
- `AllOptions`: grade de hierarquias × superfícies × tamanhos
- `Playground`: controles interativos com todos os estados
""",

    "02-atoms/button-system-warning.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonSystem } from '@cg-groupit/zodiak-design-system';
```

### Uso (variante warning)
```tsx
<ButtonSystem label="Atenção" warning={true} hierarchy="primary" />
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto do botão (obrigatório) |
| `warning` | `boolean` | `false` | Aplica ícone e cores de aviso |
| `size` | `'small' \\| 'medium'` | `'small'` | Tamanho |
| `hierarchy` | `'primary' \\| 'secondary'` | `'primary'` | Hierarquia visual |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- O ícone de aviso é decorativo (`aria-hidden`); o `label` deve transmitir o contexto completo.

### Storybook
- `AllOptions`: variante warning × hierarquias × tamanhos
- `Playground`: controles interativos
""",

    "02-atoms/button-system.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonSystem } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto do botão (obrigatório) |
| `size` | `'small' \\| 'medium'` | `'small'` | Tamanho |
| `hierarchy` | `'primary' \\| 'secondary'` | `'primary'` | Hierarquia visual |
| `warning` | `boolean` | `false` | Aplica tratamento visual de aviso |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- Estilização inline (`style`) está bloqueada; use `className` para customizações necessárias.
- Sempre forneça `label` descritivo.

### Storybook
- `AllOptions`: grade de hierarquias × tamanhos
- `Playground`: controles interativos
""",

    "02-atoms/button-video-preview.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonVideoPreview } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'play' \\| 'volume'` | `'play'` | Tipo de controle |
| `isPlaying` | `boolean` | `false` | Estado de reprodução |
| `isMuted` | `boolean` | `false` | Estado mudo (variant="volume") |
| `progress` | `number` | — | Progresso 0–1 para anel circular |
| `showRing` | `boolean` | `false` | Exibe anel de progresso |
| `background` | `'onLite' \\| 'onHeavy' \\| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `size` | `'mobile' \\| 'desktop' \\| 'desktopSmallTablet'` | `'desktop'` | Preset responsivo |

### Acessibilidade
- `aria-label` é gerado automaticamente; sobrescreva via `ariaLabel` se necessário.
- Mantenha `isPlaying` sincronizado com o estado real do vídeo.

### Storybook
- `AllOptions`: variantes × superfícies × estados de reprodução
- `Playground`: controles interativos com progresso simulado
""",

    "02-atoms/button-warning.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonRegular } from '@cg-groupit/zodiak-design-system';
```

### Uso (variante warning)
```tsx
<ButtonRegular label="Excluir" isWarning={true} hierarchy="primary" />
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto do botão |
| `isWarning` | `boolean` | `false` | Ativa tratamento visual de aviso |
| `hierarchy` | `'primary' \\| 'secondary' \\| 'tertiary'` | `'primary'` | Hierarquia visual |
| `background` | `'onLite' \\| 'onHeavy' \\| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- O `label` deve comunicar claramente a ação destrutiva (ex.: "Excluir conta").
- Considere exibir um diálogo de confirmação antes de executar ações irreversíveis.

### Storybook
- `AllOptions`: hierarquias × superfícies com `isWarning`
- `Playground`: controles interativos
""",

    "02-atoms/checkbox.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Checkbox } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto visível do checkbox |
| `checked` | `boolean` | `false` | Estado marcado (controlado) |
| `indeterminate` | `boolean` | `false` | Estado tri-state intermediário |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `state` | `'default' \\| 'error'` | `'default'` | Estado de validação |
| `helperText` | `string` | — | Texto auxiliar (visível em `state="error"`) |
| `onChange` | `ChangeEventHandler` | — | Handler de mudança (obrigatório) |

### Acessibilidade
- Forneça `aria-label` quando não houver `label` visível.
- `indeterminate` define `aria-checked="mixed"` automaticamente.

### Storybook
- `AllOptions`: estados default/error × checked/indeterminate × disabled
- `Playground`: controles interativos
""",

    "02-atoms/divider.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { DividerLine } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `thickness` | `'thin' \\| 'thick'` | `'thin'` | Espessura: thin = 0.5 px, thick = 1 px |
| `color` | `'primary' \\| 'secondary'` | `'primary'` | Conjunto de tokens de cor |

### Acessibilidade
- Renderiza `<hr>` nativo, que é anunciado como separador por screen readers.
- Use `aria-hidden="true"` apenas se o divisor for puramente decorativo e não separar seções de conteúdo.

### Storybook
- `AllOptions`: grade de espessuras × cores em light/dark
- `Playground`: controles interativos
""",

    "02-atoms/eyebrow.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Eyebrow } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `text` | `string` | — | Texto do eyebrow (obrigatório) |
| `size` | `'medium' \\| 'small'` | `'medium'` | Escala tipográfica |
| `bg` | `'onLite' \\| 'onHeavy'` | `'onLite'` | Contexto de superfície |

### Acessibilidade
- A linha decorativa ao lado do texto é renderizada com `aria-hidden="true"`.
- Mantenha o texto do eyebrow conciso (1 linha).

### Storybook
- `AllOptions`: grade de tamanhos × superfícies
- `Playground`: controles interativos
""",

    "02-atoms/flag-view.md": GAP,

    "02-atoms/icon-view.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Icon, ArrowRightIcon, CheckIcon } from '@cg-groupit/zodiak-design-system';
```

### Props principais — Icon (wrapper)
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `Component` | `React.ComponentType<IconProps>` | — | Componente SVG (obrigatório) |
| `size` | `'small' \\| 'medium' \\| 'large' \\| 'xlarge'` | `'small'` | Tamanho (16/24/32/56 px) |
| `decorative` | `boolean` | `true` | `true` → `aria-hidden`; `false` exige `aria-label` |
| `rawSize` | `string \\| number` | — | Tamanho CSS exato (sobrescreve `size`) |

### Acessibilidade
- Ícones puramente decorativos: `decorative={true}` (padrão).
- Ícones independentes com significado: `decorative={false}` + `aria-label`.

### Storybook
- `AllOptions`: grade completa de ícones disponíveis por categoria
- `Playground`: controles de tamanho, `strokeWidth` e acessibilidade
""",

    "02-atoms/list.md": GAP,

    "02-atoms/logo-view.md": GAP,

    "02-atoms/mini-menu.md": GAP,

    "02-atoms/password-field.md": GAP,

    "02-atoms/progress-indicator.md": GAP,

    "02-atoms/radio-button.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Radio } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto visível do radio |
| `value` | `string` | — | Valor enviado no formulário |
| `checked` | `boolean` | `false` | Estado selecionado (controlado) |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `state` | `'default' \\| 'error'` | `'default'` | Estado de validação |
| `helperText` | `string` | — | Mensagem de erro (state="error") |
| `onChange` | `ChangeEventHandler` | — | Handler de mudança (obrigatório) |

### Acessibilidade
- Agrupe rádios com o mesmo `name` em um `<fieldset>` + `<legend>`.
- `required` deve ser aplicado a **um** radio por grupo — o browser trata o grupo inteiro como required.

### Storybook
- `AllOptions`: estados default/error × selecionado/não-selecionado × disabled
- `Playground`: controles interativos
""",

    "02-atoms/rating.md": GAP,

    "02-atoms/search-field.md": GAP,

    "02-atoms/slider-counter.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { SliderCounter } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `totalSlides` | `number` | — | Total de slides (obrigatório) |
| `initialIndex` | `number` | `0` | Índice inicial |
| `showSlideNumber` | `boolean` | `true` | Exibe "X / Y" |
| `background` | `'onLite' \\| 'onHeavy'` | `'onLite'` | Contexto de superfície |
| `onChange` | `(meta) => void` | — | Callback com índice e direção |
| `prevAriaLabel` | `string` | `'Previous slide'` | Rótulo acessível do botão anterior |
| `nextAriaLabel` | `string` | `'Next slide'` | Rótulo acessível do botão próximo |

### Acessibilidade
- Forneça `prevAriaLabel` e `nextAriaLabel` em português para produtos em pt-BR.
- Sincronize o índice do carrossel com `onChange` para manter foco e anúncio corretos.

### Storybook
- `AllOptions`: variações de superfície e contagem de slides
- `Playground`: controles interativos com simulação de navegação
""",

    "02-atoms/tabs.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Tabs } from '@cg-groupit/zodiak-design-system';
import type { TabItem } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `tabs` | `TabItem[]` | — | Definições de abas (máx. 7, obrigatório) |
| `onTabChange` | `(index: number) => void` | — | Callback ao trocar de aba |
| `centerAlign` | `boolean` | `false` | Centraliza o strip de abas em tablet+ |
| `panelClassName` | `string` | — | Classe extra no painel de conteúdo |

### Acessibilidade
- Padrão ARIA `role="tablist"` / `role="tab"` / `role="tabpanel"` com navegação por seta.
- Cada `TabItem` deve ter `label` descritivo.

### Storybook
- `AllOptions`: variações de quantidade de abas e alinhamento
- `Playground`: controles interativos com conteúdo de painel configurável
""",

    "02-atoms/text-field.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Input } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `labelText` | `string` | — | Rótulo do campo |
| `placeholder` | `string` | — | Texto placeholder |
| `size` | `'medium' \\| 'large'` | `'medium'` | Tamanho do campo |
| `state` | `'default' \\| 'focus' \\| 'error' \\| 'success' \\| 'disabled'` | `'default'` | Estado de validação |
| `variant` | `'default' \\| 'messageFieldL' \\| 'messageFieldXL'` | `'default'` | Variante (textarea para messageField*) |
| `helperText` | `string` | — | Texto auxiliar ou de erro |
| `onChange` | `ChangeEventHandler` | — | Handler de mudança |

### Acessibilidade
- O componente associa automaticamente `<label>` ao `<input>` via `id` gerado.
- Forneça `aria-describedby` para mensagens de erro externas ao componente.

### Storybook
- `AllOptions`: estados × variantes × tamanhos
- `Playground`: controles interativos com validação simulada
""",

    "02-atoms/text-link.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Link } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `href` | `string` | — | URL de destino (obrigatório) |
| `children` | `ReactNode` | — | Conteúdo do link (obrigatório) |
| `target` | `'_blank' \\| '_self' \\| '_parent' \\| '_top'` | — | Alvo de abertura |

### Acessibilidade
- `target="_blank"` adiciona `rel="noopener noreferrer"` automaticamente.
- Use `aria-label` apenas quando o texto visível não descrever o destino (evite "Clique aqui").

### Storybook
- `AllOptions`: variações de destino e contexto de superfície
- `Playground`: controles interativos
""",

    "02-atoms/text.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Typography } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `type` | `'heading' \\| 'body'` | — | Família tipográfica (obrigatório) |
| `size` | `HeadingSize \\| BodySize` | — | Escala: Heading `6XL`…`2XS`; Body `XL`…`XS` |
| `weight` | `300 \\| 400 \\| 500` | `300` | Peso (somente type="heading") |
| `as` | `React.ElementType` | `'span'`/`'p'` | Elemento HTML semântico |

### Acessibilidade
- Sempre defina `as` com a tag semântica correta para a hierarquia de headings da página.
- Não use `Typography` para estilizar elementos interativos.

### Storybook
- `AllOptions`: grade completa de estilos heading e body em light/dark
- `Playground`: controles interativos
""",

    "02-atoms/tooltip.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Tooltip } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `content` | `ReactNode` | — | Conteúdo do tooltip (obrigatório) |
| `children` | `ReactNode` | — | Elemento gatilho (obrigatório) |
| `position` | `'top' \\| 'bottom'` | `'top'` | Posicionamento preferencial (auto-inverte) |

### Acessibilidade
- O tooltip usa `role="tooltip"` + `aria-describedby` associado ao gatilho.
- Gatilho deve ser focalizável via teclado; o componente adiciona `tabIndex` automaticamente se necessário.
- Evite colocar ações interativas dentro do conteúdo do tooltip.

### Storybook
- `AllOptions`: posições × tipos de gatilho
- `Playground`: controles interativos com conteúdo configurável
""",

    # ── 03-molecules ────────────────────────────────────────────────────────

    "03-molecules/accordion.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Accordion } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `title` | `string` | — | Rótulo do cabeçalho (obrigatório) |
| `children` | `ReactNode` | — | Conteúdo do painel |
| `initialOpen` | `boolean` | `false` | Aberto na primeira renderização |
| `grouped` | `boolean` | `false` | Modo agrupado (bordas ajustadas para stack) |
| `background` | `'default' \\| 'secondary' \\| 'none'` | `'default'` | Tratamento de fundo |
| `onToggle` | `(isOpen: boolean) => void` | — | Callback com novo estado |

### Acessibilidade
- Usa padrão ARIA `role="button"` no gatilho + `aria-expanded` + `aria-controls`.
- O painel tem `id` associado ao `aria-controls` do gatilho.

### Storybook
- `AllOptions`: single × grouped × backgrounds
- `Playground`: controles interativos com estado inicial configurável
""",

    "03-molecules/alert.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Notification } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'information' \\| 'positive' \\| 'warning'` | `'information'` | Variante semântica |
| `title` | `string` | — | Título em negrito |
| `text` | `string` | — | Corpo da mensagem |
| `firstCTA` | `boolean` | `false` | Exibe botão CTA primário |
| `secondCTA` | `boolean` | `false` | Exibe botão CTA secundário |
| `firstCtaProps` | `NotificationCtaProps` | — | Props do CTA primário |
| `onFirstCtaClick` | `MouseEventHandler` | — | Handler do CTA primário |

### Acessibilidade
- Use `role="alert"` no contêiner pai para anúncio automático em screen readers quando a notificação aparece dinamicamente.

### Storybook
- `AllOptions`: variantes × combinações de CTA
- `Playground`: controles interativos
""",

    "03-molecules/author.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Author } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `type` | `'byline' \\| 'profile'` | `'byline'` | Layout e conjunto de informações |
| `size` | `'small' \\| 'large'` | `'small'` | Tamanho (byline) |
| `name` | `string` | — | Nome do autor |
| `avatarSrc` | `string` | — | URL da foto do avatar |
| `date` | `string` | — | Data (byline) |
| `readingTime` | `string` | — | Tempo de leitura (byline) |
| `title` | `string` | — | Cargo (profile) |
| `additionalInfo` | `string` | — | Empresa / organização (profile) |

### Acessibilidade
- O avatar é decorativo por padrão; forneça `alt` descritivo em `avatarSrc` se o avatar tiver significado semântico.

### Storybook
- `AllOptions`: byline × profile × tamanhos
- `Playground`: controles interativos
""",

    "03-molecules/chip-group.md": GAP,

    "03-molecules/combobox.md": """
## Boas práticas — React/Web

> ⚠️ **Implementação parcial em React.** O componente está em progresso no pacote `@cg-groupit/zodiak-design-system`.
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar completamente, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
""",

    "03-molecules/counter-control.md": GAP,

    "03-molecules/dropdown.md": GAP,

    "03-molecules/input-wizard.md": GAP,

    "03-molecules/labelled-field.md": GAP,

    "03-molecules/multiselect.md": """
## Boas práticas — React/Web

> ⚠️ **Implementação parcial em React.** O componente está em progresso no pacote `@cg-groupit/zodiak-design-system`.
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar completamente, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
""",

    "03-molecules/notice.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Notification } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `variant` | `'information' \\| 'positive' \\| 'warning'` | `'information'` | Variante semântica |
| `title` | `string` | — | Título em negrito |
| `text` | `string` | — | Corpo da mensagem |
| `firstCTA` | `boolean` | `false` | Exibe botão CTA primário |
| `firstCtaProps` | `NotificationCtaProps` | — | Props do CTA (label, hierarchy, onClick) |

### Acessibilidade
- Notices persistentes: use `role="status"` (não intrusivo).
- Notices urgentes: use `role="alert"` (anuncia imediatamente).

### Storybook
- `AllOptions`: variantes × presença de CTA
- `Playground`: controles interativos
""",

    "03-molecules/phone-input.md": GAP,

    "03-molecules/quick-access-bar.md": GAP,

    "03-molecules/result-card.md": GAP,

    "03-molecules/slide-to-submit.md": GAP,

    "03-molecules/status-chip.md": GAP,

    "03-molecules/step-indicator.md": GAP,

    "03-molecules/switch.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Switch } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | — | Texto visível do switch |
| `checked` | `boolean` | `false` | Estado ligado/desligado (controlado) |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `side` | `'left' \\| 'right'` | `'right'` | Posição do label em relação ao toggle |
| `onChange` | `ChangeEventHandler` | — | Handler de mudança (obrigatório) |

### Acessibilidade
- Renderiza `<input type="checkbox" role="switch">` com `aria-checked` correto.
- Forneça `aria-label` quando o `label` visível não for suficiente.

### Storybook
- `AllOptions`: estados checked/unchecked × disabled × lados
- `Playground`: controles interativos
""",

    # ── 04-organisms ────────────────────────────────────────────────────────

    "04-organisms/action-compositions/link-ribbon.md": GAP,
    "04-organisms/action-compositions/professional-contact.md": GAP,
    "04-organisms/action-compositions/share-story.md": GAP,

    "04-organisms/banner.md": GAP,

    "04-organisms/card-grid.md": GAP,

    "04-organisms/card-variants/author.md": GAP,
    "04-organisms/card-variants/horizontal.md": GAP,
    "04-organisms/card-variants/reveal.md": GAP,
    "04-organisms/card-variants/short-facts.md": GAP,
    "04-organisms/card-variants/tall.md": GAP,
    "04-organisms/card-variants/typographic.md": GAP,

    "04-organisms/download-button.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonDownload } from '@cg-groupit/zodiak-design-system';
import type { DownloadItem } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `downloads` | `DownloadItem[]` | — | Lista de arquivos (obrigatório) |
| `size` | `TriggerSize` | — | Tamanho do botão gatilho |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `placement` | `string` | `'bottom-end'` | Posição do popover (floating-ui) |
| `overflowBehavior` | `'self' \\| 'page'` | `'self'` | Controle de overflow do popover |

### Acessibilidade
- O popover usa `role="menu"` com `role="menuitem"` para cada arquivo.
- Downloads em nova aba incluem indicação visual e textual.

### Storybook
- `AllOptions`: variações de quantidade de arquivos e tipos
- `Playground`: controles interativos com itens configuráveis
""",

    "04-organisms/empty-state.md": GAP,

    "04-organisms/form-container.md": GAP,

    "04-organisms/form-in-drawer.md": GAP,

    "04-organisms/hero.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Hero } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `title` | `ReactNode` | — | Título da seção (renderizado em `<h1>`) |
| `description` | `string \\| ReactNode` | — | Texto descritivo |
| `ctaLabel` | `string` | — | Label do CTA primário |
| `ctaBehavior` | `'openFullscreen' \\| 'togglePlayback'` | `'openFullscreen'` | Comportamento do CTA |
| `size` | `'small' \\| 'medium' \\| 'large'` | `'large'` | Tamanho do hero |
| `backgroundMode` | `'photo' \\| 'color' \\| 'video'` | — | Modo de fundo |
| `showCta` | `boolean` | `true` | Exibe o botão CTA principal |

### Acessibilidade
- O `<h1>` do hero deve ser o único `<h1>` da página.
- Vídeos de fundo devem respeitar `prefers-reduced-motion`.

### Storybook
- `AllOptions`: tamanhos × modos de fundo × combinações de CTA
- `Playground`: controles interativos com vídeo e foto
""",

    "04-organisms/image-compositions/carousel.md": GAP,
    "04-organisms/image-compositions/image-block.md": GAP,
    "04-organisms/image-compositions/image-text-symmetrical.md": GAP,
    "04-organisms/image-compositions/masonry-grid.md": GAP,

    "04-organisms/info-row.md": GAP,

    "04-organisms/listings.md": GAP,

    "04-organisms/login-form.md": GAP,

    "04-organisms/media-blocks/image-banner.md": GAP,
    "04-organisms/media-blocks/podcast-card.md": GAP,
    "04-organisms/media-blocks/podcast-large.md": GAP,
    "04-organisms/media-blocks/video-and-text.md": GAP,

    "04-organisms/media-blocks/video-banner.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { VideoBanner } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `title` | `ReactNode` | — | Título da seção |
| `description` | `string \\| ReactNode` | — | Texto descritivo |
| `ctaLabel` | `string` | — | Label do CTA |
| `mode` | `'none' \\| 'autoplay'` | `'none'` | Modo de reprodução automática |
| `showCta` | `boolean` | `true` | Exibe botão CTA |

### Acessibilidade
- Vídeo em autoplay deve ter `muted` e sem `prefers-reduced-motion` ativo.
- O título deve ser o heading correto para a hierarquia da página.

### Storybook
- `AllOptions`: modos de vídeo × variações de CTA
- `Playground`: controles interativos
""",

    "04-organisms/modal.md": GAP,

    "04-organisms/notification-banner.md": GAP,

    "04-organisms/pin.md": GAP,

    "04-organisms/share.md": GAP,

    "04-organisms/show-more.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { ButtonShowMore } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `label` | `string` | `'Show More'` | Texto do botão |
| `hierarchy` | `'secondary' \\| 'tertiary'` | `'secondary'` | Hierarquia visual |
| `background` | `'onLite' \\| 'onHeavy' \\| 'onPhoto'` | `'onLite'` | Contexto de superfície |
| `fullWidth` | `boolean` | `false` | Ocupa toda a largura |
| `url` | `string` | — | Renderiza como `<a>` quando fornecido |
| `disabled` | `boolean` | `false` | Estado desabilitado |

### Acessibilidade
- Quando o botão carrega mais conteúdo dinamicamente, use `aria-expanded` ou `aria-live` para anunciar o resultado.

### Storybook
- `AllOptions`: hierarquias × superfícies × fullWidth
- `Playground`: controles interativos
""",

    "04-organisms/skeleton-loader.md": GAP,

    "04-organisms/toast.md": GAP,

    "04-organisms/typographic/headline-section.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { HeadlineSection } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `text` | `string` | — | Texto do headline (obrigatório) |
| `eyebrow` | `string \\| ReactNode` | — | Label Eyebrow acima do headline |
| `description` | `string \\| ReactNode` | — | Texto de apoio abaixo do headline |
| `layout` | `'plain' \\| 'withFilter'` | `'plain'` | Modo de layout |
| `align` | `'left' \\| 'center'` | `'left'` | Alinhamento (center somente para plain) |
| `headingTag` | `'h1' \\| 'h2'` | `'h2'` | Elemento heading semântico |
| `background` | `'page' \\| 'surfaceFog'` | `'page'` | Contexto de superfície |

### Acessibilidade
- Use `headingTag="h1"` apenas para o heading principal da página.

### Storybook
- `AllOptions`: layouts × alinhamentos × fundos
- `Playground`: controles interativos
""",

    "04-organisms/typographic/key-figures.md": GAP,

    "04-organisms/typographic/preamble.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { Preamble } from '@cg-groupit/zodiak-design-system';
```

### Props principais
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `title` | `string` | — | Título do preamble |
| `subtitle` | `string` | — | Subtítulo ou lead text |
| `headingTag` | `'h1'…'h6'` | `'h1'` | Elemento heading semântico |
| `layout` | `PreambleLayoutVariant` | — | Variante de layout |
| `author` | `BylineAuthorProps` | — | Dados do autor (opcional) |
| `downloadProps` | `ButtonDownloadProps` | — | Props de download (opcional) |

### Acessibilidade
- O `headingTag` deve refletir a hierarquia real da página.
- Inclua `alt` descritivo no logo se for informativo.

### Storybook
- `AllOptions`: variantes de layout × presença de autor/download
- `Playground`: controles interativos
""",

    "04-organisms/typographic/quote.md": GAP,

    "04-organisms/typographic/text-block.md": """
## Boas práticas — React/Web

### Importação
```tsx
import { TextBlockGroup, TextBlockSection } from '@cg-groupit/zodiak-design-system';
```

### Props principais — TextBlockGroup
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `columns` | `TextBlockSectionItem[]` | — | Itens de coluna |
| `headingTag` | `TextBlockHeadingTag` | `'h2'` | Tag do heading de cada coluna |

### Props principais — TextBlockSection
| Prop | Tipo | Padrão | Descrição |
|------|------|--------|-----------|
| `items` | `TextBlockSectionItem[]` | — | Itens de seção |
| `headingTag` | `TextBlockHeadingTag` | `'h3'` | Tag do heading de cada item |

### Acessibilidade
- Defina `headingTag` compatível com a hierarquia de headings do contexto de uso.

### Storybook
- `AllOptions`: variações de grupos e seções
- `Playground`: controles interativos
""",
}

# ──────────────────────────────────────────────────────────────────────────────
# Processamento
# ──────────────────────────────────────────────────────────────────────────────

updated = []
skipped = []
errors  = []

for rel_path, section in SECTIONS.items():
    abs_path = os.path.join(BASE, rel_path)
    if not os.path.isfile(abs_path):
        errors.append(f"NAO ENCONTRADO: {rel_path}")
        continue

    with open(abs_path, "r", encoding="utf-8") as f:
        content = f.read()

    if "## Boas práticas — React/Web" in content:
        skipped.append(rel_path)
        continue

    with open(abs_path, "a", encoding="utf-8") as f:
        f.write("\n" + section.rstrip("\n") + "\n")

    updated.append(rel_path)

print(f"\n{'='*60}")
print(f"ATUALIZADOS ({len(updated)}):")
for p in updated:
    print(f"  ✓ {p}")

if skipped:
    print(f"\nJÁ TÊM SEÇÃO ({len(skipped)}) — ignorados:")
    for p in skipped:
        print(f"  - {p}")

if errors:
    print(f"\nERROS ({len(errors)}):")
    for e in errors:
        print(f"  ✗ {e}")

print(f"\nTotal: {len(updated)} atualizados, {len(skipped)} ignorados, {len(errors)} erros")
