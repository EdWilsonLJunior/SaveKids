# ImageTextSymmetrical

> **Categoria**: Organism (Image Compositions) · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog

## Contexto
Bloco simétrico: imagem à esquerda + texto à direita (ou vice-versa), 50/50. Em mobile, empilha vertical.

## Critérios de aceite
- **Layout**: 50/50 (tablet+), stacked (mobile).
- **Side**: `imageSide: .leading | .trailing`.
- **Conteúdo texto**: eyebrow + headline + body + CTA opcional.
- **Acessibilidade**: ordem coerente (mobile: imagem → texto; tablet: respeita `imageSide`).
- **Light/Dark + RTL**: imagem inverte side em RTL (configurável).

## APIs públicas
- `ZodiakImageTextSymmetrical(image: ZodiakImageSource, eyebrow: String? = none, headline: String, body: String? = none, cta: ZodiakBannerAction? = none, imageSide: ZodiakImageSide = ZodiakImageSide.leading)`.

## Boas práticas
- **iOS**: `if horizontalSizeClass == .regular { HStack } else { VStack }`.
- **Android**: `WindowSizeClass.widthSizeClass` para decidir.

## Referências
- [iOS `ZodiakImageCompositions.swift` (ZodiakImageTextSymmetrical)](../../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/ImageCompositions/ZodiakImageCompositions.swift)

## DoD
- [ ] Layout adaptativo.
- [ ] RTL.
- [ ] Ver [README família](README.md) e [ARCHITECTURE.md § 8](../../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
