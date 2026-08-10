// swiftlint:disable file_length
// Reason: File contains static geographic data for 55 offices (CapgeminiOffice array).
import MapKit
import SwiftUI

// MARK: - Office Model

private enum PinVariant {
    case hq                          // primary, large, SF building.2.fill
    case regional                    // primary, medium, SF building.2
    case office                      // secondary, small, SF building
    case delivery                    // success, small, SF checkmark
    case nearshore                   // warning/danger, small, SF person.2
    case dot                         // dot-only (no icon/label)
}

private struct CapgeminiOffice: Identifiable {
    let id = UUID()
    let city: String
    let country: String
    let flag: String
    let address: String
    let region: String
    let variant: PinVariant
    let coordinate: CLLocationCoordinate2D
}

// MARK: - Office Data (55 localizações)
// Variantes usadas para demonstrar todas as capacidades do ZodiakPin:
//   .hq        → Paris (sede global) — primary, large
//   .regional  → capitais regionais principais — primary, medium
//   .office    → escritórios-satélite — secondary, small
//   .delivery  → centros de entrega/near-shore — success, small, checkmark
//   .nearshore → nearshore/delivery BPO — danger, small, person.2
//   .dot       → presença pontual sem detalhes — dot only

private let capgeminiOffices: [CapgeminiOffice] = [
    // ── Europa ───────────────────────────────────────────────
    .init(
        city: "Paris",
        country: "shared.country.france",
        flag: "🇫🇷",
        address: "11 Rue de Tilsitt, 75017 Paris",
        region: "Europa",
        variant: .hq,
        coordinate: .init(latitude: 48.8832, longitude: 2.2938)
    ),
    .init(
        city: "Londres",
        country: "shared.country.uk",
        flag: "🇬🇧",
        address: "40 Holborn Viaduct, EC1N 2PB",
        region: "Europa",
        variant: .regional,
        coordinate: .init(latitude: 51.5074, longitude: -0.1278)
    ),
    .init(
        city: "Frankfurt",
        country: "shared.country.germany",
        flag: "🇩🇪",
        address: "Junghofstraße 14, 60311 Frankfurt am Main",
        region: "Europa",
        variant: .regional,
        coordinate: .init(latitude: 50.1109, longitude: 8.6821)
    ),
    .init(
        city: "Amsterdã",
        country: "Países Baixos",
        flag: "🇳🇱",
        address: "Papendorpseweg 100, 3528 BJ Utrecht",
        region: "Europa",
        variant: .office,
        coordinate: .init(latitude: 52.3676, longitude: 4.9041)
    ),
    .init(
        city: "Madrid",
        country: "shared.country.spain",
        flag: "🇪🇸",
        address: "Av. de Bruselas 35, Alcobendas",
        region: "Europa",
        variant: .office,
        coordinate: .init(latitude: 40.4168, longitude: -3.7038)
    ),
    .init(
        city: "Milão",
        country: "shared.country.italy",
        flag: "🇮🇹",
        address: "Via Meravigli 9, 20123 Milão",
        region: "Europa",
        variant: .office,
        coordinate: .init(latitude: 45.4654, longitude: 9.1859)
    ),
    .init(
        city: "Lisboa",
        country: "shared.country.portugal",
        flag: "🇵🇹",
        address: "Av. da Liberdade, 1250-096 Lisboa",
        region: "Europa",
        variant: .delivery,
        coordinate: .init(latitude: 38.7169, longitude: -9.1399)
    ),
    .init(
        city: "Estocolmo",
        country: "Suécia",
        flag: "🇸🇪",
        address: "Kungsgatan 12, 111 35 Stockholm",
        region: "Europa",
        variant: .office,
        coordinate: .init(latitude: 59.3293, longitude: 18.0686)
    ),
    .init(
        city: "Varsóvia",
        country: "Polônia",
        flag: "🇵🇱",
        address: "Rondo ONZ 1, 00-124 Warszawa",
        region: "Europa",
        variant: .nearshore,
        coordinate: .init(latitude: 52.2297, longitude: 21.0122)
    ),
    .init(
        city: "Praga",
        country: "Rep. Tcheca",
        flag: "🇨🇿",
        address: "Budějovická 1550, 140 00 Praha",
        region: "Europa",
        variant: .nearshore,
        coordinate: .init(latitude: 50.0755, longitude: 14.4378)
    ),
    .init(
        city: "Bucareste",
        country: "Romênia",
        flag: "🇷🇴",
        address: "Splaiul Unirii 165, Bucuresti",
        region: "Europa",
        variant: .nearshore,
        coordinate: .init(latitude: 44.4268, longitude: 26.1025)
    ),
    .init(
        city: "Bratislava",
        country: "Eslováquia",
        flag: "🇸🇰",
        address: "Karadžičova 8, 821 08 Bratislava",
        region: "Europa",
        variant: .nearshore,
        coordinate: .init(latitude: 48.1486, longitude: 17.1077)
    ),
    .init(
        city: "Budapeste",
        country: "Hungria",
        flag: "🇭🇺",
        address: "Váci út 22-24, 1132 Budapest",
        region: "Europa",
        variant: .nearshore,
        coordinate: .init(latitude: 47.4979, longitude: 19.0402)
    ),
    .init(
        city: "Kiev",
        country: "Ucrânia",
        flag: "🇺🇦",
        address: "Velyka Vasylkivska 72, Kyiv",
        region: "Europa",
        variant: .nearshore,
        coordinate: .init(latitude: 50.4501, longitude: 30.5234)
    ),
    .init(
        city: "Bruxelas",
        country: "Bélgica",
        flag: "🇧🇪",
        address: "Rue du Commerce 31, 1000 Bruxelles",
        region: "Europa",
        variant: .dot,
        coordinate: .init(latitude: 50.8503, longitude: 4.3517)
    ),
    .init(
        city: "Viena",
        country: "Áustria",
        flag: "🇦🇹",
        address: "Mariahilfer Str. 50, 1070 Wien",
        region: "Europa",
        variant: .dot,
        coordinate: .init(latitude: 48.2082, longitude: 16.3738)
    ),
    .init(
        city: "Dublin",
        country: "Irlanda",
        flag: "🇮🇪",
        address: "Two Park Place, Hatch St, Dublin",
        region: "Europa",
        variant: .dot,
        coordinate: .init(latitude: 53.3498, longitude: -6.2603)
    ),
    .init(
        city: "Luxemburgo",
        country: "Luxemburgo",
        flag: "🇱🇺",
        address: "4 Rue Lou Hemmer, Findel",
        region: "Europa",
        variant: .dot,
        coordinate: .init(latitude: 49.6117, longitude: 6.1319)
    ),
    .init(
        city: "Copenhague",
        country: "Dinamarca",
        flag: "🇩🇰",
        address: "Lautruphøj 1-3, 2750 Ballerup",
        region: "Europa",
        variant: .dot,
        coordinate: .init(latitude: 55.6761, longitude: 12.5683)
    ),
    .init(
        city: "Helsinque",
        country: "Finlândia",
        flag: "🇫🇮",
        address: "Keilaranta 7, 02150 Espoo",
        region: "Europa",
        variant: .dot,
        coordinate: .init(latitude: 60.1699, longitude: 24.9384)
    ),
    .init(
        city: "Oslo",
        country: "Noruega",
        flag: "🇳🇴",
        address: "Lysaker torg 45, 1366 Lysaker",
        region: "Europa",
        variant: .dot,
        coordinate: .init(latitude: 59.9139, longitude: 10.7522)
    ),
    .init(
        city: "Zurique",
        country: "Suíça",
        flag: "🇨🇭",
        address: "Fraumünsterstrasse 16, 8001 Zürich",
        region: "Europa",
        variant: .dot,
        coordinate: .init(latitude: 47.3769, longitude: 8.5417)
    ),
    // ── Américas ─────────────────────────────────────────────
    .init(
        city: "Nova York",
        country: "EUA",
        flag: "🇺🇸",
        address: "79 Fifth Avenue, NY 10003",
        region: "Américas",
        variant: .regional,
        coordinate: .init(latitude: 40.7358, longitude: -73.9922)
    ),
    .init(
        city: "Atlanta",
        country: "EUA",
        flag: "🇺🇸",
        address: "3475 Piedmont Rd NE, Atlanta, GA",
        region: "Américas",
        variant: .office,
        coordinate: .init(latitude: 33.8463, longitude: -84.3621)
    ),
    .init(
        city: "San Francisco",
        country: "EUA",
        flag: "🇺🇸",
        address: "1011 3rd Street, San Francisco, CA",
        region: "Américas",
        variant: .office,
        coordinate: .init(latitude: 37.7815, longitude: -122.3929)
    ),
    .init(
        city: "Toronto",
        country: "shared.country.canada",
        flag: "🇨🇦",
        address: "130 Adelaide St W, Toronto, ON M5H 2K4",
        region: "Américas",
        variant: .office,
        coordinate: .init(latitude: 43.6532, longitude: -79.3832)
    ),
    .init(
        city: "São Paulo (JK)",
        country: "shared.country.brazil",
        flag: "🇧🇷",
        address: "Av. Pres. Juscelino Kubitschek, SP",
        region: "América Latina",
        variant: .regional,
        coordinate: .init(latitude: -23.5870, longitude: -46.6788)
    ),
    .init(
        city: "Barueri",
        country: "shared.country.brazil",
        flag: "🇧🇷",
        address: "Alameda Grajaú, 60, Alphaville, 06454-050",
        region: "América Latina",
        variant: .delivery,
        coordinate: .init(latitude: -23.4867, longitude: -46.8483)
    ),
    .init(
        city: "Rio de Janeiro",
        country: "shared.country.brazil",
        flag: "🇧🇷",
        address: "Av. Almirante Barroso, 81, RJ",
        region: "América Latina",
        variant: .office,
        coordinate: .init(latitude: -22.9068, longitude: -43.1729)
    ),
    .init(
        city: "Belo Horizonte",
        country: "shared.country.brazil",
        flag: "🇧🇷",
        address: "Av. dos Andradas, 3000, WeWork BH",
        region: "América Latina",
        variant: .nearshore,
        coordinate: .init(latitude: -19.9167, longitude: -43.9345)
    ),
    .init(
        city: "Curitiba",
        country: "shared.country.brazil",
        flag: "🇧🇷",
        address: "Curitiba, PR",
        region: "América Latina",
        variant: .dot,
        coordinate: .init(latitude: -25.4284, longitude: -49.2733)
    ),
    .init(
        city: "Buenos Aires",
        country: "shared.country.argentina",
        flag: "🇦🇷",
        address: "Tucumán 1, Edificio República 8F, C1048",
        region: "Américas",
        variant: .office,
        coordinate: .init(latitude: -34.6037, longitude: -58.3759)
    ),
    .init(
        city: "Bogotá",
        country: "shared.country.colombia",
        flag: "🇨🇴",
        address: "Cra. 7 #71-21, Bogotá",
        region: "América Latina",
        variant: .nearshore,
        coordinate: .init(latitude: 4.7110, longitude: -74.0721)
    ),
    .init(
        city: "Cidade do México",
        country: "shared.country.mexico",
        flag: "🇲🇽",
        address: "Paseo de la Reforma 250, CDMX",
        region: "América Latina",
        variant: .office,
        coordinate: .init(latitude: 19.4326, longitude: -99.1332)
    ),
    .init(
        city: "San José",
        country: "Costa Rica",
        flag: "🇨🇷",
        address: "Escazú, San José",
        region: "América Central",
        variant: .nearshore,
        coordinate: .init(latitude: 9.9281, longitude: -84.0907)
    ),
    .init(
        city: "Cidade da Guatemala",
        country: "Guatemala",
        flag: "🇬🇹",
        address: "Guatemala City, GT",
        region: "América Central",
        variant: .dot,
        coordinate: .init(latitude: 14.6349, longitude: -90.5069)
    ),
    // ── Ásia-Pacífico ─────────────────────────────────────────
    .init(
        city: "Mumbai",
        country: "shared.country.india",
        flag: "🇮🇳",
        address: "Godrej BKC, Bandra Kurla Complex, Mumbai",
        region: "Ásia-Pacífico",
        variant: .regional,
        coordinate: .init(latitude: 19.0760, longitude: 72.8777)
    ),
    .init(
        city: "Bangalore",
        country: "shared.country.india",
        flag: "🇮🇳",
        address: "Prestige Shantiniketan, ITPL Main Rd",
        region: "Ásia-Pacífico",
        variant: .delivery,
        coordinate: .init(latitude: 12.9716, longitude: 77.5946)
    ),
    .init(
        city: "Pune",
        country: "shared.country.india",
        flag: "🇮🇳",
        address: "Hinjawadi Phase I, Pune 411057",
        region: "Ásia-Pacífico",
        variant: .nearshore,
        coordinate: .init(latitude: 18.5912, longitude: 73.7389)
    ),
    .init(
        city: "Tóquio",
        country: "shared.country.japan",
        flag: "🇯🇵",
        address: "3-7-1 Kasumigaseki, Chiyoda, Tokyo",
        region: "Ásia-Pacífico",
        variant: .regional,
        coordinate: .init(latitude: 35.6762, longitude: 139.6503)
    ),
    .init(
        city: "Pequim",
        country: "shared.country.china",
        flag: "🇨🇳",
        address: "Guomao CBD, Beijing",
        region: "Ásia-Pacífico",
        variant: .office,
        coordinate: .init(latitude: 39.9042, longitude: 116.4074)
    ),
    .init(
        city: "Xangai",
        country: "shared.country.china",
        flag: "🇨🇳",
        address: "Lujiazui, Pudong, Shanghai",
        region: "Ásia-Pacífico",
        variant: .office,
        coordinate: .init(latitude: 31.2304, longitude: 121.4737)
    ),
    .init(
        city: "Singapura",
        country: "Singapura",
        flag: "🇸🇬",
        address: "168 Robinson Road, Capital Tower #14-01",
        region: "Ásia-Pacífico",
        variant: .regional,
        coordinate: .init(latitude: 1.3521, longitude: 103.8198)
    ),
    .init(
        city: "Sydney",
        country: "shared.country.australia",
        flag: "🇦🇺",
        address: "Level 7, 60 Martin Place, Sydney NSW 2000",
        region: "Ásia-Pacífico",
        variant: .office,
        coordinate: .init(latitude: -33.8688, longitude: 151.2093)
    ),
    .init(
        city: "Auckland",
        country: "Nova Zelândia",
        flag: "🇳🇿",
        address: "Auckland CBD, NZ",
        region: "Ásia-Pacífico",
        variant: .dot,
        coordinate: .init(latitude: -36.8485, longitude: 174.7633)
    ),
    .init(
        city: "Kuala Lumpur",
        country: "Malásia",
        flag: "🇲🇾",
        address: "Level 6 Menara IMC, KL Sentral",
        region: "Ásia-Pacífico",
        variant: .nearshore,
        coordinate: .init(latitude: 3.1390, longitude: 101.6869)
    ),
    .init(
        city: "Manila",
        country: "Filipinas",
        flag: "🇵🇭",
        address: "Bonifacio Global City, Taguig",
        region: "Ásia-Pacífico",
        variant: .nearshore,
        coordinate: .init(latitude: 14.5547, longitude: 121.0244)
    ),
    .init(
        city: "Bangkok",
        country: "Tailândia",
        flag: "🇹🇭",
        address: "Sathorn Sq, Silom, Bangkok",
        region: "Ásia-Pacífico",
        variant: .dot,
        coordinate: .init(latitude: 13.7563, longitude: 100.5018)
    ),
    .init(
        city: "Ho Chi Minh City",
        country: "Vietnã",
        flag: "🇻🇳",
        address: "Sunwah Tower, 115 Nguyen Hue Blvd",
        region: "Ásia-Pacífico",
        variant: .nearshore,
        coordinate: .init(latitude: 10.7769, longitude: 106.7009)
    ),
    // ── África & Oriente Médio ────────────────────────────────
    .init(
        city: "Dubai",
        country: "Emirados Árabes",
        flag: "🇦🇪",
        address: "Emaar Square, Downtown Dubai",
        region: "Oriente Médio",
        variant: .regional,
        coordinate: .init(latitude: 25.2048, longitude: 55.2708)
    ),
    .init(
        city: "Riyadh",
        country: "Arábia Saudita",
        flag: "🇸🇦",
        address: "Al Faisaliah Tower, Riyadh",
        region: "Oriente Médio",
        variant: .office,
        coordinate: .init(latitude: 24.6877, longitude: 46.7219)
    ),
    .init(
        city: "Casablanca",
        country: "Marrocos",
        flag: "🇲🇦",
        address: "Bd d'Anfa, Casablanca",
        region: "África",
        variant: .nearshore,
        coordinate: .init(latitude: 33.5731, longitude: -7.5898)
    ),
    .init(
        city: "Cairo",
        country: "Egito",
        flag: "🇪🇬",
        address: "Smart Village, Cairo-Alex Desert Rd",
        region: "África",
        variant: .nearshore,
        coordinate: .init(latitude: 30.0444, longitude: 31.2357)
    ),
    .init(
        city: "Tunis",
        country: "Tunísia",
        flag: "🇹🇳",
        address: "Les Berges du Lac, Tunis",
        region: "África",
        variant: .nearshore,
        coordinate: .init(latitude: 36.8065, longitude: 10.1815)
    )
]

// MARK: - PinVariant → ZodiakPin helper

private extension CapgeminiOffice {
    @ViewBuilder
    func pinView(isSelected: Bool, onTap: @escaping () -> Void) -> some View {
        switch variant {
        case .hq:
            ZodiakPin(icon: "building.2.fill", style: .primary, size: .large,
                      isSelected: isSelected, onTap: onTap)

        case .regional:
            ZodiakPin(icon: "building.2", style: .primary, size: .medium,
                      isSelected: isSelected, onTap: onTap)

        case .office:
            ZodiakPin(icon: "building", style: .secondary, size: .small,
                      isSelected: isSelected, onTap: onTap)

        case .delivery:
            ZodiakPin(icon: "checkmark", style: .success, size: .small,
                      isSelected: isSelected, onTap: onTap)

        case .nearshore:
            ZodiakPin(icon: "person.2", style: .danger, size: .small,
                      isSelected: isSelected, onTap: onTap)

        case .dot:
            ZodiakPin(style: .secondary, size: .small,
                      isSelected: isSelected, onTap: onTap)
        }
    }
}

// MARK: - PinVariant display helpers

private extension PinVariant {
    var legendLabel: String {
        switch self {
        case .hq:        return "Sede Global (HQ)"
        case .regional:  return "Escritório Regional"
        case .office:    return "Escritório"
        case .delivery:  return "Centro de Entrega"
        case .nearshore: return "Nearshore / BPO"
        case .dot:       return "Presença"
        }
    }

    var legendSpec: String {
        switch self {
        case .hq:        return "primary · large · building.2.fill"
        case .regional:  return "primary · medium · building.2"
        case .office:    return "secondary · small · building"
        case .delivery:  return "success · small · checkmark"
        case .nearshore: return "danger · small · person.2"
        case .dot:       return "secondary · small · dot only"
        }
    }

    @ViewBuilder var pinPreview: some View {
        switch self {
        case .hq:        ZodiakPin(icon: "building.2.fill", style: .primary, size: .large)
        case .regional:  ZodiakPin(icon: "building.2", style: .primary, size: .medium)
        case .office:    ZodiakPin(icon: "building", style: .secondary, size: .small)
        case .delivery:  ZodiakPin(icon: "checkmark", style: .success, size: .small)
        case .nearshore: ZodiakPin(icon: "person.2", style: .danger, size: .small)
        case .dot:       ZodiakPin(                         style: .secondary, size: .small)
        }
    }
}

// MARK: - Gallery View

struct PinGalleryView: View {
    @State private var selectedOffice: CapgeminiOffice?
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.pin",
                subtitle: "catalog.pin.subtitle",
                figmaRef: "Organisms › Feedback and Status › Pin"
            )

            // MARK: Estilos e tamanhos
            gallerySectionCard(title: "catalog.section.estilos") {
                // Cabeçalho de colunas
                PinSizeHeader()

                ZodiakDivider(hierarchy: .secondary)

                // Uma linha por estilo
                PinStyleRow(style: .primary, icon: "mappin", label: "catalog.spec.style_primary")
                ZodiakDivider(hierarchy: .secondary)
                PinStyleRow(style: .secondary, icon: "mappin", label: "catalog.spec.style_secondary")
                ZodiakDivider(hierarchy: .secondary)
                PinStyleRow(style: .danger, icon: "exclamationmark", label: "Danger")
                ZodiakDivider(hierarchy: .secondary)
                PinStyleRow(style: .success, icon: "checkmark", label: "catalog.spec.label_success")

                ZodiakDivider(hierarchy: .primary)

                ZodiakInfoRow(
                    "catalog.spec.lbl.bubble",
                    value: "catalog.spec.val.circulo_com_sf_symbol_label_ou_dot",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.tail",
                    value: "catalog.spec.val.triangulo_apontando_para_baixo",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.border",
                    value: "catalog.spec.val.borderless_quando_primarysuccessdanger",
                    style: .spec()
                )
            }

            gallerySectionCard(title: "catalog.section.conteudo_do_pin") {
                ZodiakEyebrow(text: "Ícone SF Symbol")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom, spacing: ZodiakSpacing.s32) {
                        PinSample(pin: ZodiakPin(icon: "mappin", style: .primary, size: .medium), label: "mappin")
                        PinSample(
                            pin: ZodiakPin(icon: "building.2.fill", style: .primary, size: .medium),
                            label: "building.2.fill"
                        )
                        PinSample(
                            pin: ZodiakPin(icon: "building.2", style: .primary, size: .medium),
                            label: "building.2"
                        )
                        PinSample(pin: ZodiakPin(icon: "building", style: .secondary, size: .medium), label: "building")
                        PinSample(pin: ZodiakPin(icon: "person.2", style: .danger, size: .medium), label: "person.2")
                        PinSample(pin: ZodiakPin(icon: "checkmark", style: .success, size: .medium), label: "checkmark")
                        PinSample(pin: ZodiakPin(icon: "star.fill", style: .primary, size: .medium), label: "star.fill")
                        PinSample(pin: ZodiakPin(icon: "wifi", style: .secondary, size: .medium), label: "wifi")
                    }
                    .padding(.bottom, ZodiakSpacing.s4)
                }

                ZodiakDivider(hierarchy: .secondary)
                ZodiakEyebrow(text: "Label de texto")
                HStack(alignment: .bottom, spacing: ZodiakSpacing.s32) {
                    PinSample(pin: ZodiakPin(label: "A", style: .primary, size: .medium), label: "\"A\"")
                    PinSample(pin: ZodiakPin(label: "1", style: .primary, size: .large), label: "\"1\" large")
                    PinSample(pin: ZodiakPin(label: "42", style: .secondary, size: .medium), label: "\"42\"")
                    PinSample(pin: ZodiakPin(label: "!", style: .danger, size: .medium), label: "\"!\"")
                }

                ZodiakDivider(hierarchy: .secondary)
                ZodiakEyebrow(text: "Dot only (sem ícone/label)")
                HStack(alignment: .bottom, spacing: ZodiakSpacing.s32) {
                    PinSample(pin: ZodiakPin(style: .primary, size: .small), label: "primary")
                    PinSample(pin: ZodiakPin(style: .secondary, size: .small), label: "secondary")
                    PinSample(pin: ZodiakPin(style: .secondary, size: .medium), label: "medium")
                }

                ZodiakDivider(hierarchy: .primary)
                ZodiakInfoRow(
                    "catalog.spec.lbl.icone",
                    value: "catalog.spec.val.sf_symbol_escala_38_do_diametro",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.label",
                    value: "catalog.spec.val.texto_curto_max_1_linha",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.dot",
                    value: "catalog.spec.val.sem_conteudo_apenas_bolha_colorida",
                    style: .spec()
                )
            }

            gallerySectionCard(title: "catalog.section.estado_de_selecao") {
                PinSelectionDemo()

                ZodiakDivider(hierarchy: .primary)
                ZodiakInfoRow(
                    "catalog.spec.lbl.normal",
                    value: "catalog.spec.val.tamanho_base_sem_ring",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.selected",
                    value: "catalog.spec.val.scale_115_ring_branco_interno_borda_acti",
                    style: .spec()
                )
            }

            // MARK: Escritórios Capgemini
            if sizeClass == .regular {
                // iPad — mapa e detalhe lado a lado
                gallerySectionCard(title: "catalog.section.escritorios_capgemini") {
                    ZodiakText(
                        // swiftlint:disable:next line_length
                        "MapKit com ZodiakPin como annotation · \(capgeminiOffices.count) escritórios · ← → para navegar",
                        style: .body(color: .secondary)
                    )

                    HStack(alignment: .top, spacing: ZodiakSpacing.s24) {
                        CapgeminiMapView(
                            offices: capgeminiOffices,
                            selectedOffice: $selectedOffice,
                            mapHeight: 560
                        )
                        .frame(maxWidth: .infinity)

                        ZodiakDivider(hierarchy: .secondary)
                            .frame(width: 1)
                            .frame(maxHeight: .infinity)

                        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                            if let office = selectedOffice {
                                HStack(spacing: ZodiakSpacing.s4) {
                                    ZodiakText(office.flag, style: .title2)
                                    ZodiakText(office.city, style: .title2)
                                    if office.variant == .hq { ZodiakSuccessBadge(text: "catalog.spec.quality_hq") }
                                }
                                ZodiakDivider(hierarchy: .secondary)
                                OfficeDetailContent(office: office)
                            } else {
                                ZodiakEmptyState(
                                    icon: "mappin.and.ellipse",
                                    title: "Nenhum escritório",
                                    description: "Toque num pin ou use ← → para selecionar um escritório."
                                )
                            }
                        }
                        .frame(minWidth: 240, maxWidth: 340)
                        .frame(maxHeight: .infinity, alignment: .top)
                    }

                    ZodiakInfoRow(
                        "catalog.spec.lbl.tecnologia",
                        value: "catalog.spec.val.mapkit_map_annotation",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.interacao",
                        value: "catalog.spec.val.toque_trackpadmouse_teclado",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.variantes",
                        value: "catalog.spec.val.6_tipos_de_pin_ver_seccao_legenda_de_var",
                        style: .spec()
                    )
                }
            } else {
                // iPhone — vertical
                gallerySectionCard(title: "catalog.section.escritorios_capgemini") {
                    ZodiakText(
                        // swiftlint:disable:next line_length
                        "MapKit com ZodiakPin como annotation · \(capgeminiOffices.count) escritórios · ← → para navegar",
                        style: .body(color: .secondary)
                    )

                    CapgeminiMapView(
                        offices: capgeminiOffices,
                        selectedOffice: $selectedOffice,
                        mapHeight: 480
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.tecnologia",
                        value: "catalog.spec.val.mapkit_map_annotation",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.interacao",
                        value: "catalog.spec.val.toque_trackpadmouse_teclado",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.variantes",
                        value: "catalog.spec.val.6_tipos_de_pin_ver_seccao_legenda_de_var",
                        style: .spec()
                    )
                }

                if let office = selectedOffice {
                    gallerySectionCard(title: "\(office.flag)  \(office.city)") {
                        if office.variant == .hq { ZodiakSuccessBadge(text: "catalog.spec.hq_capgemini") }
                        OfficeDetailContent(office: office)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }

            // MARK: Legenda de variantes
            gallerySectionCard(title: "catalog.section.legenda_de_variantes") {
                PinVariantLegendRow(variant: .hq)
                ZodiakDivider(hierarchy: .secondary)
                PinVariantLegendRow(variant: .regional)
                ZodiakDivider(hierarchy: .secondary)
                PinVariantLegendRow(variant: .office)
                ZodiakDivider(hierarchy: .secondary)
                PinVariantLegendRow(variant: .delivery)
                ZodiakDivider(hierarchy: .secondary)
                PinVariantLegendRow(variant: .nearshore)
                ZodiakDivider(hierarchy: .secondary)
                PinVariantLegendRow(variant: .dot)
            }
        }
        .zodiakPage(title: "catalog.component_name.pin")
    }
}

// MARK: - MapKit View

private struct CapgeminiMapView: View {
    let offices: [CapgeminiOffice]
    @Binding var selectedOffice: CapgeminiOffice?
    var mapHeight: CGFloat = 480

    @State private var focusedIndex: Int = 0
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: .init(latitude: 25, longitude: 15),
            span: .init(latitudeDelta: 140, longitudeDelta: 330)
        )
    )

    var body: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            Map(position: $position) {
                ForEach(offices) { office in
                    Annotation(office.city, coordinate: office.coordinate, anchor: .bottom) {
                        office.pinView(
                            isSelected: selectedOffice?.id == office.id,
                            onTap: { select(office) }
                        )
                        .accessibilityLabel("\(office.city), \(office.country)")
                        .accessibilityHint("shared.action.tap_for_details")
                    }
                }
            }
            .mapStyle(.standard)
            .mapControls {
                MapCompass()
                MapScaleView()
            }
            .frame(height: mapHeight)
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .strokeBorder(ZodiakColors.borderPrimary, lineWidth: 1)
            )

            // Barra de navegação
            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakIconButton(
                    icon: "chevron.left",
                    action: { navigate(by: -1) },
                    size: .small,
                    style: .tertiary,
                    accessibilityLabel: "Escritório anterior"
                )
                .keyboardShortcut(.leftArrow, modifiers: [])

                Spacer()

                if selectedOffice != nil {
                    ZodiakText(verbatim: "\(focusedIndex + 1) / \(offices.count)", style: .body(bold: true))
                } else {
                    ZodiakText("Toque num pin ou use ← →", style: .caption())
                        .lineLimit(1)
                }

                Spacer()

                ZodiakIconButton(
                    icon: "chevron.right",
                    action: { navigate(by: 1) },
                    size: .small,
                    style: .tertiary,
                    accessibilityLabel: "Próximo escritório"
                )
                .keyboardShortcut(.rightArrow, modifiers: [])
            }
        }
    }

    private func select(_ office: CapgeminiOffice) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
            selectedOffice = selectedOffice?.id == office.id ? nil : office
            focusedIndex = offices.firstIndex(where: { $0.id == office.id }) ?? focusedIndex
        }
    }

    private func navigate(by delta: Int) {
        focusedIndex = (focusedIndex + delta + offices.count) % offices.count
        let office = offices[focusedIndex]
        withAnimation(.easeInOut(duration: 0.4)) {
            selectedOffice = office
            position = .region(MKCoordinateRegion(
                center: office.coordinate,
                span: .init(latitudeDelta: 8, longitudeDelta: 8)
            ))
        }
    }
}

// MARK: - Office Detail (inline)

private struct OfficeDetailContent: View {
    let office: CapgeminiOffice

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakInfoRow(label: "País", value: "\(office.flag)  \(office.country)")
            ZodiakInfoRow(label: "Região", value: office.region)
            ZodiakInfoRow(label: "Endereço", value: office.address)
            ZodiakInfoRow(label: "Tipo", value: office.variant.legendLabel)
        }
    }
}

// MARK: - Pin Variant Legend Row

private struct PinVariantLegendRow: View {
    let variant: PinVariant

    var body: some View {
        HStack(alignment: .center, spacing: ZodiakSpacing.s24) {
            variant.pinPreview
                .frame(width: 48, alignment: .center)
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText(variant.legendLabel, style: .body(bold: true))
                ZodiakText(variant.legendSpec, style: .caption())
            }
            Spacer()
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }
}

// MARK: - Style Grid Helpers

/// Cabeçalho de colunas: estilo | Small | Medium | Large
private struct PinSizeHeader: View {
    var body: some View {
        HStack {
            Text("catalog.spec.label_style")
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textDisabled)
                .frame(minWidth: 72, alignment: .leading)
            Spacer()
            ForEach(
                ["catalog.spec.size_small", "catalog.spec.size_medium", "catalog.spec.size_large"],
                id: \.self
            ) { size in
                Text(size)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textDisabled)
                    .frame(width: 60, alignment: .center)
            }
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }
}

/// Uma linha da matriz: rótulo + 3 pins (small/medium/large) do mesmo estilo
private struct PinStyleRow: View {
    let style: ZodiakPinStyle
    let icon: String
    let label: String

    var body: some View {
        HStack {
            ZodiakEyebrow(text: label, size: .small)
                .frame(minWidth: 72, alignment: .leading)
            Spacer()
            ZodiakPin(icon: icon, style: style, size: .small)
                .frame(width: 60, alignment: .center)
            ZodiakPin(icon: icon, style: style, size: .medium)
                .frame(width: 60, alignment: .center)
            ZodiakPin(icon: icon, style: style, size: .large)
                .frame(width: 60, alignment: .center)
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }
}

/// Coluna simples: pin + label abaixo
private struct PinSample<P: View>: View {
    let pin: P
    let label: String

    var body: some View {
        VStack(spacing: ZodiakSpacing.s4) {
            pin
            ZodiakText(label, style: .caption())
                .lineLimit(1)
                .fixedSize()
        }
    }
}

/// Demo interativa de seleção com toggle ao toque
private struct PinSelectionDemo: View {
    @State private var selectedIndex: Int? = 1

    private let items: [(String, ZodiakPinStyle, ZodiakPin.ZodiakPinSize)] = [
        ("mappin", .primary, .small),
        ("building.2.fill", .primary, .large),
        ("checkmark", .success, .medium),
        ("exclamationmark", .danger, .medium),
        ("mappin", .secondary, .medium)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakEyebrow(text: "Toque num pin para selecionar")
            HStack(alignment: .bottom, spacing: ZodiakSpacing.s32) {
                ForEach(items.indices, id: \.self) { i in
                    let (icon, style, size) = items[i]
                    ZodiakPin(
                        icon: icon,
                        style: style,
                        size: size,
                        isSelected: selectedIndex == i,
                        // swiftlint:disable:next line_length
                        onTap: { withAnimation(.spring(response: 0.3)) { selectedIndex = selectedIndex == i ? nil : i } }
                    )
                }
            }
        }
    }
}

#Preview { NavigationStack { PinGalleryView() } }
