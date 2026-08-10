<!-- Phase 6 — Pull Request template ZodiakiOS -->

## Resumo

<!-- Descreva em 1-3 frases o que esta PR muda. -->

## Tipo de mudança

- [ ] Bug fix (não-quebrante, corrige issue)
- [ ] Nova feature (não-quebrante, adiciona funcionalidade)
- [ ] Mudança quebrante (afeta APIs públicas / componentes existentes)
- [ ] Documentação / tooling

## Checklist Zodiak DS

- [ ] **SwiftLint** verde: `swiftlint lint --strict --config .swiftlint.yml`
- [ ] **Build** verde: `xcodebuild -project ZodiakiOS.xcodeproj -scheme ZodiakiOS build`
- [ ] **Tests** verdes: `xcodebuild test -destination 'platform=iOS Simulator,name=iPhone 17'`
- [ ] **Dark mode** validado em Preview (light + dark)
- [ ] **iPad** validado em Preview (iPhone + iPad Pro 13" portrait/landscape)
- [ ] **Acessibilidade** — `accessibilityLabel`/`Identifier` adicionados onde aplicável; AX1/AX5 sem truncamento
- [ ] **Localização** — chaves novas adicionadas em `en.lproj/Localizable.strings` E `pt-BR.lproj/Localizable.strings`
- [ ] **Design System** — nenhum hardcoded color/font/spacing fora de `Shared/DesignSystem/Tokens/`
- [ ] **Audit script** verde: `python3 scripts/audit_dark_mode.py --strict`

## Screenshots / GIFs

<!-- Anexe captures em light + dark + iPhone + iPad quando relevante. -->

## Documentação relacionada

<!-- Cite docs atualizados (zodiak-ds-fidelity.md, accessibility-audit.md, etc). -->

## Notas para o reviewer

<!-- Áreas específicas para atenção, riscos, decisões de trade-off. -->
