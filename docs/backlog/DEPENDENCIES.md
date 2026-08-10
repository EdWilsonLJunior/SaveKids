# Dependências & Cronograma — Zodiak DS

Diagramas Mermaid mostrando a ordem de implementação e as dependências entre camadas (foundations → theme → atoms → molecules → organisms → templates) seguindo Atomic Design.

> **Regra**: cada camada só pode consumir camadas inferiores. Composição direta entre componentes da mesma camada é permitida **apenas** dentro de famílias que compartilham um primitivo (`ZodiakCardImpl`, `ZodiakTypographicBlockImpl`).

---

## 1. Visão macro (fases sequenciais)

```mermaid
flowchart LR
    F[00 · Foundations<br/>tokens] --> T[01 · Theme<br/>ZodiakTheme + provider]
    T --> A[02 · Atoms<br/>33 componentes]
    A --> M[03 · Molecules<br/>18 componentes]
    M --> O[04 · Organisms<br/>44 componentes]
    A --> O
    O --> TP[05 · Templates<br/>4 componentes]
    M --> TP
    A --> TP
    U[06 · Utils] -.cross-cutting.-> A
    U -.cross-cutting.-> M
    U -.cross-cutting.-> O
    U -.cross-cutting.-> TP
```

---

## 2. Foundations — ordem interna

```mermaid
flowchart TD
    P[Primitives raw palette] --> C[Colors]
    C --> Ty[Typography]
    P --> Sp[Spacing]
    P --> Sz[Sizing]
    Sz --> HT[Hit-target]
    P --> R[Radii]
    P --> B[Borders]
    C --> Sh[Shadows]
    C --> Bl[Blurs]
    Sz --> G[Grid]
    C --> Ic[Icons]
    C --> Fl[Flags]
    C --> Lg[Logo]
    C --> Gr[Gradients]
    P --> AR[Aspect Ratios]
    P --> Op[Opacity]
    P --> Mt[Motion]
    P --> Df[Defaults]
```

---

## 3. Atoms — dependências (resumo)

Atoms consomem **apenas tokens** (foundations + theme). Sem composição entre atoms.

```mermaid
mindmap
  root((Tokens))
    Texto e Tipografia
      Text
      TextLink
      Eyebrow
    Mídia e Assets
      IconView
      FlagView
      LogoView
      Avatar
    Estrutura e Feedback
      Divider
      Badge
      List
      Tabs
      Rating
      Tooltip
      ProgressIndicator
      SkeletonLoader
    Formulários e Controles
      Checkbox
      RadioButton
      TextField
      PasswordField
      SearchField
      SliderCounter
    Navegação
      MiniMenu
      BreadcrumbPagination
    Botões
      ButtonRegular
      ButtonArrow
      ButtonIcon
      ButtonMedia
      ButtonFilter
      ButtonMenu
      ButtonNav
      ButtonSystem
      ButtonSystemWarning
      ButtonWarning
      ButtonVideoPreview
```

---

## 4. Molecules — composição

```mermaid
flowchart LR
    subgraph atoms [Atoms]
        Text
        IconView
        FlagView
        Avatar
        Divider
        Badge
        Checkbox
        TextField
        ButtonRegular
        ButtonIcon
    end

    subgraph molecules [Molecules]
        Alert
        Author
        Notice
        ChipGroup
        StatusChip
        Combobox
        Dropdown
        Multiselect
        Switch
        PhoneInput
        StepIndicator
        Accordion
        CounterControl
        QuickAccessBar
        ResultCard
        SlideToSubmit
        LabelledField
        InputWizard
    end

    Text --> Alert
    IconView --> Alert
    ButtonRegular --> Alert

    Avatar --> Author
    Text --> Author

    Text --> Notice
    IconView --> Notice

    Badge --> ChipGroup
    Badge --> StatusChip

    TextField --> Combobox
    IconView --> Combobox
    FlagView --> Combobox

    TextField --> Dropdown
    IconView --> Dropdown

    Checkbox --> Multiselect
    Text --> Multiselect

    Text --> Switch

    TextField --> PhoneInput
    FlagView --> PhoneInput
    Combobox --> PhoneInput

    Text --> StepIndicator
    IconView --> StepIndicator

    Text --> Accordion
    IconView --> Accordion
    Divider --> Accordion

    ButtonIcon --> CounterControl
    TextField --> CounterControl

    ButtonIcon --> QuickAccessBar
    Text --> QuickAccessBar

    Avatar --> ResultCard
    Text --> ResultCard
    Badge --> ResultCard

    Text --> SlideToSubmit
    IconView --> SlideToSubmit

    Text --> LabelledField
    TextField --> LabelledField

    Text --> InputWizard
    LabelledField --> InputWizard
    ButtonRegular --> InputWizard
    StepIndicator --> InputWizard
```

---

## 5. Organisms — composição (chains principais)

```mermaid
flowchart LR
    Text --> Banner
    IconView --> Banner
    ButtonIcon --> Banner

    Text --> Toast
    IconView --> Toast

    Text --> Modal
    ButtonRegular --> Modal
    ButtonIcon --> Modal

    Text --> Hero
    ButtonRegular --> Hero

    TextField --> Pin
    Text --> Pin

    LogoView --> LoginForm
    LabelledField --> LoginForm
    TextField --> LoginForm
    PasswordField --> LoginForm
    ButtonRegular --> LoginForm
    TextLink --> LoginForm

    IconView --> Share
    ButtonIcon --> Share
    Text --> Share

    Notice --> NotificationBanner
    Text --> NotificationBanner
    ButtonIcon --> NotificationBanner

    Text --> Listings
    ResultCard --> Listings
    SkeletonLoader --> Listings
    EmptyState --> Listings

    Text --> EmptyState
    IconView --> EmptyState
    ButtonRegular --> EmptyState

    LabelledField --> FormContainer
    ButtonRegular --> FormContainer

    FormContainer --> FormInDrawer

    Text --> InfoRow
    IconView --> InfoRow

    Text --> ShowMore
    ButtonRegular --> ShowMore

    ButtonRegular --> DownloadButton
    ProgressIndicator --> DownloadButton

    SkeletonLoader

    subgraph cards [Família Cards]
        CardImpl[ZodiakCardImpl primitivo]
        CardHorizontal
        CardTypographic
        CardAuthor
        CardReveal
        CardTall
        CardShortFacts
        CardGrid
    end

    Text --> CardImpl
    IconView --> CardImpl
    Avatar --> CardImpl
    Badge --> CardImpl
    CardImpl --> CardHorizontal
    CardImpl --> CardTypographic
    CardImpl --> CardAuthor
    CardImpl --> CardReveal
    CardImpl --> CardTall
    CardImpl --> CardShortFacts

    CardImpl --> CardGrid

    subgraph typo [Família Tipográfica]
        TypoImpl[ZodiakTypographicBlockImpl primitivo]
        Quote
        TextBlock
        Preamble
        KeyFigures
        HeadlineSection
    end

    Text --> TypoImpl
    TypoImpl --> Quote
    TypoImpl --> TextBlock
    TypoImpl --> Preamble
    TypoImpl --> KeyFigures
    TypoImpl --> HeadlineSection

    subgraph images [Família Imagens]
        ImageBlock
        Carousel
        MasonryGrid
        ImageTextSymmetrical
        VideoBanner
        ImageBanner
        VideoAndText
    end

    IconView --> ImageBlock
    Text --> ImageBlock
    ImageBlock --> Carousel
    ImageBlock --> MasonryGrid
    ImageBlock --> ImageTextSymmetrical

    Text --> LinkRibbon
    IconView --> LinkRibbon
    Avatar --> ProfessionalContact
    Text --> ProfessionalContact
    ButtonIcon --> ProfessionalContact
    ButtonRegular --> ShareStory

    subgraph podcast [Família Podcast]
        PodcastCard
        PodcastLarge
    end

    ImageBlock --> PodcastCard
    Text --> PodcastCard
    ButtonIcon --> PodcastCard
    PodcastCard --> PodcastLarge

    ImageBlock --> VideoBanner
    ButtonVideoPreview --> VideoBanner

    ImageBlock --> ImageBanner

    ImageBlock --> VideoAndText
    Text --> VideoAndText
```

---

## 6. Templates

```mermaid
flowchart LR
    Tokens --> LayoutGrid
    Tokens --> Viewport
    LayoutGrid --> AdaptiveTemplate
    Viewport --> AdaptiveTemplate
    Viewport --> ActivityTemplate
    LayoutGrid --> ActivityTemplate
```

---

## 7. Cronograma (Gantt — ondas de implementação)

```mermaid
timeline
    title Zodiak DS — Ondas de implementação
    section Infra
        Wave 0 · Foundations : Primitives & raw palette : Colors & Typography : Spacing · Sizing · Radii : Borders · Shadows · Blurs : Grid · Icons · Flags · Logo : Motion · Opacity · Aspect-ratios · Defaults
        Wave 1 · Theme + Utils : ZodiakTheme provider : FontModifier · View modifiers · Extensions · Preview helpers
    section Componentes
        Wave 2 · Atoms P0 : Text · TextLink · Eyebrow · IconView · Divider · Badge : TextField · PasswordField · SearchField : ButtonRegular (4 APIs) : ButtonIcon · ButtonArrow · ButtonSystem : Checkbox · RadioButton · Switch base · Tabs
        Wave 3 · Atoms P1 : Avatar · List · Rating · Tooltip · Progress · Flag · Logo : ButtonFilter · ButtonMedia · ButtonMenu · ButtonNav · ButtonWarning · ButtonVideoPreview : SliderCounter · MiniMenu · BreadcrumbPagination
        Wave 4 · Molecules P0 : LabelledField · Notice (3 APIs) · Alert : Switch · ChipGroup · StatusChip · StepIndicator : Combobox · Dropdown · Multiselect · PhoneInput : CounterControl · Accordion · QuickAccessBar : ResultCard · SlideToSubmit · InputWizard · Author
        Wave 5 · Organisms P0 : Modal · Toast · Banner · NotificationBanner : LoginForm · Pin · FormContainer · FormInDrawer : Hero · ShowMore · Listings · EmptyState : SkeletonLoader · InfoRow · DownloadButton · Share
        Wave 6 · Organisms Famílias : CardImpl + 6 variantes Card · CardGrid : TypographicBlockImpl + 5 stories : ImageBlock · Carousel · MasonryGrid · ImageTextSymmetrical : PodcastCard · PodcastLarge · VideoBanner · ImageBanner · VideoAndText : LinkRibbon · ProfessionalContact · ShareStory
        Wave 7 · Templates : LayoutGrid · Viewport : AdaptiveTemplate · ActivityTemplate
```

---

## 8. Caminho crítico (P0 mínimo para destravar app)

```mermaid
flowchart LR
    F0[Foundations P0] --> T0[Theme]
    T0 --> A0[Atoms P0:<br/>Text + IconView + Button + TextField + Checkbox]
    A0 --> M0[Molecules P0:<br/>LabelledField + Notice + Alert]
    M0 --> O0[Organisms P0:<br/>Modal + Toast + LoginForm + Form-container]
    O0 --> TP0[Templates P0:<br/>LayoutGrid + Viewport + Adaptive]
```

---

## 9. Notas de leitura

- Setas indicam **dependência de composição** (A → B significa B consome A).
- Linhas tracejadas em §1 indicam dependência cross-cutting (utils são usados em todas as camadas mas não compõem outros componentes).
- Primitivos internos (`ZodiakCardImpl`, `ZodiakTypographicBlockImpl`, `ZodiakButtonImpl`, etc.) aparecem em §5 dentro de subgrafos das respectivas famílias.
- Agrupamentos visuais: §3 usa **mindmap** por categorias; §4 e §5 usam **subgraphs** para separar camadas; §7 usa **timeline** para as ondas de entrega.

Para detalhe por componente, ver cada história em [02-atoms/](02-atoms/), [03-molecules/](03-molecules/), [04-organisms/](04-organisms/), [05-templates/](05-templates/), [06-utils/](06-utils/).
