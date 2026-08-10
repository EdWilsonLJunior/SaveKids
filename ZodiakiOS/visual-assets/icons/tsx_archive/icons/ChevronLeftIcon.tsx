import { IconProps } from "../IconProps.js";

export const ChevronLeftIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Chevron_Left">
      <path
        id="Vector"
        d="M9.9987 12.6673L5.33203 8.00065L9.9987 3.33398"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
