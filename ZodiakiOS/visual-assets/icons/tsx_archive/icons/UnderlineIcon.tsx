import { IconProps } from "../IconProps.js";

export const UnderlineIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Underline">
      <path
        id="Vector"
        d="M4 12.6673H12M5.33333 3.33398V7.33398C5.33333 8.80674 6.52724 10.0007 8 10.0007C9.47276 10.0007 10.6667 8.80674 10.6667 7.33398V3.33398"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
