import { IconProps } from "../IconProps.js";

export const ChevronUpIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Chevron_Up">
      <path
        id="Vector"
        d="M3.33203 10.6667L7.9987 6L12.6654 10.6667"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
