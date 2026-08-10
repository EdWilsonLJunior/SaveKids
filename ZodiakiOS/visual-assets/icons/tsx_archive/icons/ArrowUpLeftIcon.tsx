import { IconProps } from "../IconProps.js";

export const ArrowUpLeftIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Up_Left">
      <path
        id="Vector"
        d="M11.3346 11.3327L4.66797 4.66602M4.66797 4.66602V9.99935M4.66797 4.66602H10.0013"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
