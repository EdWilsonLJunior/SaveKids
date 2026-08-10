import { IconProps } from "../IconProps.js";

export const TextIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Text">
      <path
        id="Vector"
        d="M6.66667 12.6673H8M8 12.6673H9.33333M8 12.6673V3.33398M8 3.33398H4V4.00065M8 3.33398H12V4.00065"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
