import { IconProps } from "../IconProps.js";

export const TextAlignJustifyIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Text_Align_Justify">
      <path
        id="Vector"
        d="M13.3346 12H2.66797M13.3346 9.33333H2.66797M13.3346 6.66667H2.66797M13.3346 4H2.66797"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
