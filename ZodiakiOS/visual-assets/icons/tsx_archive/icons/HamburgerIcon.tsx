import { IconProps } from "../IconProps.js";

export const HamburgerIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Menu, Name=Hamburger">
      <path
        id="Vector"
        d="M3.33203 11.3327H12.6654M3.33203 7.99935H12.6654M3.33203 4.66602H12.6654"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
