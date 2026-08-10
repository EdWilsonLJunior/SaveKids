import { IconProps } from "./IconProps.js";

export type IconSize = "small" | "medium" | "large" | "xlarge";

export const sizeMap: Record<IconSize, { size: string, strokeWidth: number }> = {
    small: { size: "16px", strokeWidth: 1 },
    medium: { size: "24px", strokeWidth: 1.4 },
    large: { size: "32px", strokeWidth: 1.8 },
    xlarge: { size: "56px", strokeWidth: 2.8 },
}

export interface IconWrapperProps {
    Component: React.ComponentType<IconProps>;  // Any icon component
    size?: IconSize;                            // Preset size
    rawSize?: string | number;                  // Escape hatch for custom sizes
    strokeWidth?: number;                       // Optional override
    className?: string;                         // Additional CSS classes
    decorative?: boolean;                       // If true, aria-hidden
    title?: string;                             // Accessibility label
}

const toCssSize = (v: string | number) => (typeof v === "number" ? `${v}px` : v);

export const Icon = ({
    Component,
    size = "small",
    rawSize,
    className = "",
    decorative = true,
    title = "",
    strokeWidth,
    ...props
}: IconWrapperProps) => {
    const config = sizeMap[size];
    const finalSize = rawSize !== undefined ? toCssSize(rawSize) : config.size;
    const finalStrokeWidth = strokeWidth ?? config.strokeWidth;
    const accessibilityProps = decorative
        ? { "aria-hidden": true as const }
        : { role: "img" as const, "aria-label": title || "icon" };
    return (
        <span className={`zodiak-icon ${className}`.trim()}>
            <Component
                width={finalSize}
                height={finalSize}
                strokeWidth={finalStrokeWidth}
                {...accessibilityProps}
                {...props}
            />
        </span>
    );
};