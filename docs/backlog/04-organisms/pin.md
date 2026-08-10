# Pin / PinMap

> **Categoria**: Organism · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
`ZodiakPin` é um marcador (pin) usado em mapas Zodiak. `ZodiakPinMap` é o organism completo que renderiza um mapa com pins (combina MapKit / Google Maps Compose + pins DS).

## História de usuário
Como **usuário**, quero **ver localizações em mapa** com **pins padronizados** e **estados claros**.

## Critérios de aceite

### Cenário 1 — Pin estados
**Dado** `state: .default/.selected/.cluster`
**Então** visuais corretos via tokens.

### Cenário 2 — Map
**Dado** `ZodiakPinMap(items:)`
**Então** mapa renderiza com pins; tap em pin seleciona.

### Cenário 3 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** pin anuncia "Pin: <título>"; mapa fornece overlay de lista acessível.

### Cenário 4 — Light/Dark
**Dado** dark
**Então** estilo do mapa muda (Apple Maps dark / Google Maps night).

### Cenário 5 — Cluster
**Dado** zoom out com muitos pins
**Então** clusters agregam ("12+").

## Spec técnica

### APIs públicas
- `ZodiakPin(title: String? = none, icon: ZodiakIcon? = none, state: ZodiakPinState = ZodiakPinState.default)`.
- `ZodiakPinMap(items: [ZodiakPinMapItem], region: Binding<MapRegion>, onSelect: (ZodiakPinMapItem) -> Void)`.

### Tokens
- Pin cor: `actionPrimary` (default), `statusError`/`statusWarning` por contexto.
- Sombra: `shadows.level2`.

## Boas práticas — iOS
- MapKit: `Map(coordinateRegion:annotationItems:)` + `MapAnnotation` custom.
- HIG: [Maps](https://developer.apple.com/design/human-interface-guidelines/maps).

## Boas práticas — Android
- Google Maps Compose (`com.google.maps.android:maps-compose`).
- `GoogleMap { Marker(state, icon) }` com bitmap custom = `ZodiakPin`.

## Acessibilidade
- Mapas sempre têm alternativa em lista.
- Anunciar nome do pin selecionado.

## Referências
- [iOS `Organisms/Pin/ZodiakPin.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Organisms/Pin/ZodiakPin.swift)

## Gaps & dúvidas para o time de Design
- [ ] Cluster visual oficial?
- [ ] Estilo de mapa custom (cores Zodiak)?

## DoD
- [ ] Pin + Map.
- [ ] Lista alternativa para a11y.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
