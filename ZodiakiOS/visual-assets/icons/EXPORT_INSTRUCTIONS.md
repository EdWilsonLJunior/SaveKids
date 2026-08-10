# Zodiak Icons — Export Instructions

Coloque os SVGs exportados do Figma nesta pasta, depois rode o script de import.

## 1. Export do Figma

1. Abra o arquivo Figma do Zodiak:  
   **[Icons component](https://www.figma.com/file/GMwVFGRj6CM8j82jmkAJXB?node-id=40000103:1838)**

2. Selecione todos os ícones no painel de assets (ou frame a frame).

3. No painel **Export** (lado direito), configure:
   - Format: **SVG**
   - Scale: **1×**
   - Suffix: *(vazio)*
   - **Contents Only**: ✅ (sem fundo)

4. Nomeie cada arquivo seguindo a convenção:

   | Nome no Figma | Nome do arquivo SVG |
   |---|---|
   | `Add_Plus` | `zodiak-icon-add-plus.svg` |
   | `AI_Brain` | `zodiak-icon-ai-brain.svg` |
   | `Arrow_Down` | `zodiak-icon-arrow-down.svg` |
   | `Play Filled` | `zodiak-icon-play-filled.svg` |

   **Regra geral:** `zodiak-icon-` + nome em lowercase com `_` e espaços substituídos por `-`.

5. Salve todos os SVGs nesta pasta (`visual-assets/icons/`).

## 2. Import para o xcassets

Na raiz do projeto, rode:

```bash
bash scripts/import-visual-assets.sh
```

O script detecta automaticamente os arquivos nesta pasta e cria um imageset para cada ícone em `Assets.xcassets/`, com:
- `preserves-vector-representation: true`
- `template-rendering-intent: template` *(permite colorização via `.foregroundStyle`)*

## 3. Verificação

Após o import, `ZodiakIconView` renderizará os SVGs reais automaticamente — o fallback `square.dashed` desaparecerá.

Para confirmar no Xcode: **Assets.xcassets** → filtre por `zodiak-icon-`.

## Referência de nomes

Ver enum completo em [`Shared/DesignSystem/Tokens/ZodiakIcons.swift`](../../../Shared/DesignSystem/Tokens/ZodiakIcons.swift) — propriedade `imageName` de cada caso.
