import SwiftUI

// MARK: - Reports Tab View
struct ReportsTabView: View {
    @ObservedObject var viewModel: ProductManagerViewModel

    var body: some View {
        VStack(spacing: ZodiakSpacing.s32) {
            if viewModel.products.isEmpty {
                ZodiakEmptyState(
                    icon: "chart.bar.xaxis",
                    title: "feature.product_manager.reports_empty_title",
                    description: "feature.product_manager.reports_empty_desc"
                )
            } else {
                summarySection
                brandSection
                segmentSection
            }
        }
    }

    // MARK: - Summary Section

    private var summarySection: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            ZodiakInfoRow(
                label: String(localized: "feature.product_manager.report_count"),
                value: "\(viewModel.products.count)"
            )
            ZodiakInfoRow(
                label: String(localized: "feature.product_manager.report_avg_price"),
                value: String(format: "R$ %.2f", ProductService.averagePrice(viewModel.products))
            )
        }
    }

    // MARK: - Brand Section

    private var brandSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("feature.product_manager.reports_by_brand", style: .title2)
            ForEach(viewModel.byBrand, id: \.key) { group in
                ZodiakAccordion(verbatim: group.key, leadingIcon: "tag") {
                    VStack(spacing: ZodiakSpacing.s4) {
                        ZodiakInfoRow(
                            label: String(localized: "feature.product_manager.report_count"),
                            value: "\(group.value.count)"
                        )
                        ZodiakInfoRow(
                            label: String(localized: "feature.product_manager.report_avg_price"),
                            value: String(format: "R$ %.2f", ProductService.averagePrice(group.value))
                        )
                    }
                }
            }
        }
    }

    // MARK: - Segment Section

    private var segmentSection: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakText("feature.product_manager.reports_by_segment", style: .title2)
            ForEach(viewModel.bySegment, id: \.key) { group in
                ZodiakAccordion(
                    verbatim: NSLocalizedString(group.key.rawValue, comment: ""),
                    leadingIcon: segmentIcon(group.key)
                ) {
                    VStack(spacing: ZodiakSpacing.s4) {
                        ZodiakInfoRow(
                            label: String(localized: "feature.product_manager.report_count"),
                            value: "\(group.value.count)"
                        )
                        ZodiakInfoRow(
                            label: String(localized: "feature.product_manager.report_avg_price"),
                            value: String(format: "R$ %.2f", ProductService.averagePrice(group.value))
                        )
                    }
                }
            }
        }
    }

    private func segmentIcon(_ segment: ProductSegment) -> String {
        switch segment {
        case .food:        return "fork.knife"
        case .electronics: return "cpu"
        case .home:        return "house"
        }
    }
}
