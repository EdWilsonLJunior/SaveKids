import { IconProps } from "../IconProps.js";

export const ArrowDownLeftIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Down_Left">
      <path
        id="Vector"
        d="M11.3346 4.66602L4.66797 11.3327M4.66797 11.3327H10.0013M4.66797 11.3327V5.99935"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
