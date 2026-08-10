import { IconProps } from "../IconProps.js";

export const ArrowUpIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Up">
      <path
        id="Vector"
        d="M8 12.6673V3.33398M8 3.33398L4 7.33398M8 3.33398L12 7.33398"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
