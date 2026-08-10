# PhoneInput

> **Categoria**: Molecule · **Prioridade**: P1 · **Plataformas**: iOS · Android · **Status**: Backlog · **Doc Supernova**: Não

## Contexto
Campo de telefone com seletor de país (bandeira + DDI) à esquerda e número à direita. Aplicação automática de máscara conforme país.

## História de usuário
Como **usuário**, quero **digitar meu telefone** com **DDI selecionável e máscara aplicada automaticamente**.

## Critérios de aceite

### Cenário 1 — Composição
**Dado** `ZodiakPhoneInput(value:, country:)`
**Então** layout: `[Flag DDI ▾] [+55] [(11) 99999-9999]`.

### Cenário 2 — Mudança de país
**Dado** seletor abre via tap
**Quando** seleciono país
**Então** DDI atualiza; máscara é reaplicada.

### Cenário 3 — Validação
**Dado** número incompleto
**Então** error inline; texto helper mostra formato esperado.

### Cenário 4 — Acessibilidade
**Dado** VoiceOver/TalkBack
**Então** "Telefone, código <país>, <número>, campo de telefone".

### Cenário 5 — Teclado
**Dado** campo focado
**Então** keyboard numérico (`phonePad` / `KeyboardType.Phone`).

## Spec técnica

### APIs públicas
- `ZodiakPhoneInput(value: Binding<String>, country: Binding<Country>, label: String = "Telefone", helper/error..., enabled: Bool = true)`.

### Implementação
- `HStack { ZodiakCountryCombobox; ZodiakTextFieldImpl }`. Aplicar máscara via library (libphonenumber-iOS / Google libphonenumber).

### Tokens
- Herda text-field.

## Boas práticas — iOS
- `.keyboardType(.phonePad)`.
- `.textContentType(.telephoneNumber)` para AutoFill.
- libphonenumber-iOS para formatação.

## Boas práticas — Android
- `KeyboardOptions(keyboardType = KeyboardType.Phone)`.
- `Modifier.semantics { contentType = ContentType.PhoneNumber }` (Material 3 Expressive).
- `PhoneNumberUtil` (libphonenumber) para máscara.

## Acessibilidade
- Anunciar DDI + número juntos.
- Combobox de país acessível independentemente.

## Referências
- [iOS `Molecules/PhoneInput/ZodiakPhoneInput.swift`](../../ZodiakiOS/ZodiakiOS/Shared/DesignSystem/Molecules/PhoneInput/ZodiakPhoneInput.swift)

## Gaps & dúvidas para o time de Design
- [ ] Lista oficial de países suportados?
- [ ] Formato exibido (E.164 vs nacional)?

## DoD
- [ ] Máscara por país.
- [ ] AutoFill telephoneNumber.
- [ ] Ver [ARCHITECTURE.md § 8](../ARCHITECTURE.md#8-definition-of-done--comum-a-todas-as-histórias).


## Boas práticas — React/Web

> ⚠️ **Componente ainda não portado para React.**
> Acompanhe o progresso em `docs/backlog/GAPS.md`.
> Ao implementar, seguir o padrão de 6 arquivos: `.tsx` + `.scss` + `.test.tsx` + `.stories.tsx` + `CHANGELOG.md` + `index.ts`.
