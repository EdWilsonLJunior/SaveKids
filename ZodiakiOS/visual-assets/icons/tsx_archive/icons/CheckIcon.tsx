import { IconProps } from "../IconProps.js";

export const CheckIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Check">
      <path
        id="Vector"
        d="M4 8.00033L6.82843 10.8288L12.4847 5.17188"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
