import { IconProps } from "../IconProps.js";

export const ArrowDownRightIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Down_Right">
      <path
        id="Vector"
        d="M4.66797 4.66602L11.3346 11.3327M11.3346 11.3327V5.99935M11.3346 11.3327H6.0013"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
