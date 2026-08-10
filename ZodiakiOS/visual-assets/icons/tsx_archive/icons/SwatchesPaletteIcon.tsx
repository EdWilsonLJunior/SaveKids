import { IconProps } from "../IconProps.js";

export const SwatchesPaletteIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Swatches_Palette">
      <path
        id="Vector"
        d="M4.33333 14.0007H13.6471C13.842 14.0007 14.0002 13.8427 14.0002 13.6478L14 9.68685M5.32031 13.7815L13.7614 9.84538C13.9381 9.763 14.0145 9.55296 13.9321 9.3763L12.2581 5.78678C12.1758 5.61012 11.9657 5.53341 11.7891 5.61579L8.02018 7.3734M6.58788 12.2705C6.25435 13.5153 4.9749 14.254 3.73014 13.9204C2.48539 13.5869 1.74654 12.3076 2.08007 11.0628L4.49064 2.06641C4.54109 1.87812 4.73445 1.76635 4.92273 1.8168L8.7487 2.84179C8.93699 2.89224 9.04874 3.08572 8.99829 3.274L6.58788 12.2705ZM4.33333 11.734H4.33467L4.33464 11.7354L4.33333 11.7354V11.734Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
