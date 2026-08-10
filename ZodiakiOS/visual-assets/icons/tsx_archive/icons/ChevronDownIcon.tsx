import { IconProps } from "../IconProps.js";

export const ChevronDownIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Chevron_Down">
      <path
        id="Vector"
        d="M12.6654 6L7.9987 10.6667L3.33203 6"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
