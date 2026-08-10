import SwiftUI

// MARK: - ZodiakInfoRowStyle
/// Controla a apresentação visual de ZodiakInfoRow.
///
/// - `.data`: Destaca um dado de domínio (ex: "Média: 8.5"). Label em body/secondary,
///   valor em body/bold, fundo surface com cornerRadius. Uso: features e screens.
///
/// - `.spec`: Apresenta uma especificação técnica compacta (ex: "Radius · 4pt").
///   Ambos em caption, label com largura fixa, sem fundo. Uso: catálogo e documentação.
enum ZodiakInfoRowStyle {
    case data
    case spec(labelWidth: CGFloat = 90)
}

// MARK: - ZodiakInfoRow
/// Linha label | valor.
///
/// Suporta dois estilos via `ZodiakInfoRowStyle`:
/// - `.data` (padrão): uso em features/screens para exibir dados de domínio.
/// - `.spec`: uso em catálogo/documentação para tabelas de especificações técnicas.
struct ZodiakInfoRow: View {
    let label: LocalizedStringKey
    let value: LocalizedStringKey
    var style: ZodiakInfoRowStyle = .data

    /// Inicializador nomeado com String — mantém compatibilidade com todos os call sites existentes.
    init(label: String, value: String, style: ZodiakInfoRowStyle = .data) {
        self.label = LocalizedStringKey(label)
        self.value = LocalizedStringKey(value)
        self.style = style
    }

    /// Inicializador posicional com LocalizedStringKey — usado pelo wrapper `specRow` e novos call sites.
    init(_ label: LocalizedStringKey, value: LocalizedStringKey, style: ZodiakInfoRowStyle = .data) {
        self.label = label
        self.value = value
        self.style = style
    }

    var body: some View {
        switch style {
        case .data:
            HStack {
                ZodiakText(label, style: .body(color: .secondary))
                Spacer()
                ZodiakText(value, style: .body(bold: true))
            }
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surface)
            .cornerRadius(ZodiakRadii.s)

        case .spec(let labelWidth):
            HStack(alignment: .top) {
                Text(label)
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .frame(width: labelWidth, alignment: .leading)
                Text(value)
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                Spacer()
            }
        }
    }
}

// MARK: - ZodiakFormWrapper
/// Container vertical genérico para agrupar campos de formulário

struct ZodiakFormWrapper<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            content
        }
        .padding(ZodiakSpacing.s16)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: ZodiakSpacing.s16) {
        // .data — uso em features
        ZodiakInfoRow(label: "Média:", value: "8.5")
        ZodiakInfoRow(label: "Status:", value: "shared.state.passed")

        ZodiakDivider(hierarchy: .secondary)

        // .spec — uso no catálogo
        ZodiakInfoRow("Radius", value: "ZodiakRadii.s · 8pt", style: .spec())
        ZodiakInfoRow("Padding", value: "ZodiakSpacing.s8 · 8pt", style: .spec())
        ZodiakInfoRow("Fonte", value: "caption · 12pt", style: .spec())

        ZodiakFormWrapper {
            ZodiakLabelledField(
                label: "shared.label.name",
                placeholder: "shared.placeholder.type_here",
                text: .constant(""))
        }
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
