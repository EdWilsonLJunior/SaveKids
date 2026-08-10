import { IconProps } from "../IconProps.js";

export const TextAlignLeftIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Text_Align_Left">
      <path
        id="Vector"
        d="M2.66797 12H9.33464M2.66797 9.33333H13.3346M2.66797 6.66667H9.33464M2.66797 4H13.3346"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
