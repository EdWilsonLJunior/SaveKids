import { IconProps } from "../IconProps.js";

export const ChevronLastPageIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor",
  strokeWidth = 1,
  className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <path
      d="M12.0833 12.5L12.0833 3.49996M3.91668 3.33329L8.58334 7.99996L3.91668 12.6666"
      stroke={color}
      stroke-linecap="round"
      stroke-linejoin="round"
    />
  </svg>
);
