import { IconProps } from "../IconProps.js";

export const LeafIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Environment, Name=Leaf">
      <path
        id="Vector"
        d="M4.55143 11.3877C9.26548 14.2161 13.0367 10.4449 12.5653 3.37385C5.49438 2.90244 1.72331 6.67379 4.55143 11.3877ZM4.55143 11.3877C4.55138 11.3876 4.55149 11.3878 4.55143 11.3877ZM4.55143 11.3877L3.33203 12.6067M4.55143 11.3877L7.10327 8.83544"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
