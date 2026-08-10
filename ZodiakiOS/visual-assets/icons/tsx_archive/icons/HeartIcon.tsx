import { IconProps } from "../IconProps.js";

export const HeartIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Heart">
      <path
        id="Vector"
        d="M8 5.13019C6.66667 2.00057 2 2.3339 2 6.33392C2 10.3339 8 13.6674 8 13.6674C8 13.6674 14 10.3339 14 6.33392C14 2.3339 9.33333 2.00057 8 5.13019Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
