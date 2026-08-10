import { IconProps } from "../IconProps.js";

export const ArrowUpRightIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Up_Right">
      <path
        id="Vector"
        d="M4.66797 11.3327L11.3346 4.66602M11.3346 4.66602H6.0013M11.3346 4.66602V9.99935"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
