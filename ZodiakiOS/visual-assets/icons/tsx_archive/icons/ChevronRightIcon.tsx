import { IconProps } from "../IconProps.js";

export const ChevronRightIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Chevron_Right">
      <path
        id="Vector"
        d="M6 3.33398L10.6667 8.00065L6 12.6673"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
 