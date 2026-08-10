import SwiftUI

// MARK: - Icon Buttons Gallery View
// Covers: ZodiakIconButton, ZodiakCloseButton, ZodiakArrowButton
// Figma: "Button icon", "Button close", "Button arrow"

struct IconButtonsGalleryView: View {
    @State private var selectedStyle: ZodiakIconButtonStyle = .primary
    @State private var selectedSize: ZodiakIconButtonSize = .medium
    @State private var selectedContext: ZodiakIconButtonContext = .onLite
    @State private var isEnabled = true

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.icon_buttons",
                subtitle: "catalog.icon_buttons.subtitle",
                figmaRef: "Button icon, Button close, Button arrow"
            )

            // MARK: Icon Button Playground
            gallerySectionCard(title: "catalog.section.playground_icon_button") {
                    playgroundPreview

                    Picker("catalog.spec.label_style", selection: $selectedStyle) {
                        Text("catalog.spec.style_primary").tag(ZodiakIconButtonStyle.primary)
                        Text("catalog.spec.style_secondary").tag(ZodiakIconButtonStyle.secondary)
                        Text("catalog.spec.style_tertiary").tag(ZodiakIconButtonStyle.tertiary)
                    }
                    .pickerStyle(.segmented)

                    Picker("catalog.spec.label_size", selection: $selectedSize) {
                        Text("catalog.spec.size_small").tag(ZodiakIconButtonSize.small)
                        Text("catalog.spec.size_medium").tag(ZodiakIconButtonSize.medium)
                        Text("catalog.spec.size_large").tag(ZodiakIconButtonSize.large)
                    }
                    .pickerStyle(.segmented)

                    Picker("catalog.spec.label_context", selection: $selectedContext) {
                        Text(verbatim: "onLite").tag(ZodiakIconButtonContext.onLite)
                        Text(verbatim: "onHeavy").tag(ZodiakIconButtonContext.onHeavy)
                        Text(verbatim: "onPhoto").tag(ZodiakIconButtonContext.onPhoto)
                    }
                    .pickerStyle(.segmented)

                    Toggle("catalog.section.enabled", isOn: $isEnabled)
                        .tint(ZodiakColors.actionPrimary)
                        .font(ZodiakTypography.bodySmall)
            }

            // MARK: All Icon Variants — onLite
            gallerySectionCard(title: "catalog.section.variantes_por_estilo") {
                    ForEach([
                        ("primary", ZodiakIconButtonStyle.primary, "catalog.iconbuttons.variant_primary_desc"),
                        ("secondary", .secondary, "catalog.iconbuttons.variant_secondary_desc"),
                        ("tertiary", .tertiary, "catalog.iconbuttons.variant_tertiary_desc")
                    ], id: \.0) { name, style, descKey in
                        HStack(spacing: ZodiakSpacing.s8) {
                            ZodiakIconButton(icon: "heart.fill", action: {}, size: .medium, style: style)
                            ZodiakIconButton(
                                icon: "heart.fill",
                                action: {},
                                size: .medium,
                                style: style,
                                isEnabled: false
                            )
                            VStack(alignment: .leading, spacing: 2) {
                                Text(name).font(ZodiakTypography.bodySmall).foregroundColor(ZodiakColors.textPrimary)
                                Text(LocalizedStringKey(descKey))
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(ZodiakColors.textSecondary)
                            }
                            Spacer()
                        }
                        .padding(.vertical, ZodiakSpacing.s4)
                    }
            }

            // MARK: Contextos onHeavy / onPhoto
            gallerySectionCard(title: "catalog.section.context_variants") {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                        Text(verbatim: "onHeavy")
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.textAlwaysWhite)
                        HStack(spacing: ZodiakSpacing.s16) {
                            Spacer()
                            ZodiakIconButton(icon: "heart.fill", action: {}, style: .primary, context: .onHeavy)
                            ZodiakIconButton(icon: "heart.fill", action: {}, style: .secondary, context: .onHeavy)
                            ZodiakIconButton(icon: "heart.fill", action: {}, style: .tertiary, context: .onHeavy)
                            ZodiakIconButton(
                                icon: "heart.fill", action: {}, style: .primary, context: .onHeavy, isEnabled: false
                            )
                            Spacer()
                        }
                    }
                    .padding(ZodiakSpacing.s8)
                    .frame(maxWidth: .infinity)
                    .background(ZodiakColors.surfaceInk)
                    .cornerRadius(ZodiakRadii.s)

                    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                        Text(verbatim: "onPhoto — secondary only")
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.textAlwaysWhite)
                        HStack(spacing: ZodiakSpacing.s16) {
                            Spacer()
                            ZodiakIconButton(icon: "heart.fill", action: {}, style: .secondary, context: .onPhoto)
                            ZodiakIconButton(
                                icon: "heart.fill", action: {}, style: .secondary, context: .onPhoto, isEnabled: false
                            )
                            Spacer()
                        }
                    }
                    .padding(ZodiakSpacing.s8)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            colors: [ZodiakColors.surfaceMarine, ZodiakColors.surfaceInk],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
            }

            // MARK: Sizes
            gallerySectionCard(title: "catalog.section.tamanhos") {
                    HStack(spacing: ZodiakSpacing.s16) {
                        Spacer()
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakIconButton(icon: "plus", action: {}, size: .small)
                            Text("catalog.iconbuttons.desc_0")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakIconButton(icon: "plus", action: {}, size: .medium)
                            Text("catalog.iconbuttons.desc_1")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakIconButton(icon: "plus", action: {}, size: .large)
                            Text("catalog.iconbuttons.desc_2")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
            }

            // MARK: Close Button
            gallerySectionCard(title: "catalog.section.button_close") {
                    Text("catalog.iconbuttons.desc_3")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    HStack(spacing: ZodiakSpacing.s8) {
                        Spacer()
                        ZodiakCloseButton(action: {})
                        Text(verbatim: "ZodiakCloseButton")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        Spacer()
                    }
            }

            // MARK: Arrow Button
            gallerySectionCard(title: "catalog.section.button_arrow") {
                    Text("catalog.iconbuttons.desc_4")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                        ZodiakArrowLink(title: "catalog.iconbuttons.arrow_example_1", action: {})
                        ZodiakArrowLink(title: "catalog.iconbuttons.arrow_example_2", action: {})
                        ZodiakArrowLink(title: "catalog.iconbuttons.arrow_example_3", action: {}, direction: .left)
                        ZodiakArrowLink(
                            title: "catalog.iconbuttons.arrow_example_disabled", action: {}, isEnabled: false
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.forma",
                        value: "catalog.spec.val.circular_clipshape_circle",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.tamanhos",
                        value: "catalog.spec.val.small_38pt_medium_48pt_large_56pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.icone",
                        value: "catalog.spec.val.sf_symbols_systemname",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.touch_target",
                        value: "catalog.spec.val.minimo_44pt_via_frame",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.disabled",
                        value: "catalog.spec.val.actiondisabled_bg_actiondisabledcontent",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component.icon_buttons")
    }
}

// MARK: - Playground Preview
private extension IconButtonsGalleryView {
    @ViewBuilder
    var playgroundPreview: some View {
        ZStack {
            if selectedContext == .onPhoto {
                LinearGradient(
                    colors: [ZodiakColors.surfaceMarine, ZodiakColors.surfaceInk],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else if selectedContext == .onHeavy {
                ZodiakColors.surfaceInk
            } else {
                ZodiakColors.surfaceSmoke
            }

            HStack(spacing: ZodiakSpacing.s24) {
                VStack(spacing: ZodiakSpacing.s4) {
                    ZodiakIconButton(
                        icon: "star.fill",
                        action: {},
                        size: selectedSize,
                        style: selectedStyle,
                        context: selectedContext,
                        isEnabled: isEnabled
                    )
                    Text(verbatim: "enabled")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(
                            selectedContext == .onLite
                                ? ZodiakColors.textSecondary
                                : ZodiakColors.textAlwaysWhite
                        )
                }
                VStack(spacing: ZodiakSpacing.s4) {
                    ZodiakIconButton(
                        icon: "star.fill",
                        action: {},
                        size: selectedSize,
                        style: selectedStyle,
                        context: selectedContext,
                        isEnabled: false
                    )
                    Text(verbatim: "disabled")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(
                            selectedContext == .onLite
                                ? ZodiakColors.textSecondary
                                : ZodiakColors.textAlwaysWhite
                        )
                }
            }
            .padding(ZodiakSpacing.s24)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
        .animation(.easeInOut(duration: 0.2), value: selectedContext)
    }
}

// MARK: - Preview
#Preview { NavigationStack { IconButtonsGalleryView() } }
