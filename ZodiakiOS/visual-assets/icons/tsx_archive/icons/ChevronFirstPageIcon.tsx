import { IconProps } from "../IconProps.js";

export const ChevronFirstPageIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor",
  strokeWidth = 1,
  className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <path
      d="M3.91667 3.49998L3.91667 12.5M12.0833 12.6666L7.41667 7.99998L12.0833 3.33331"
      stroke={color}
      stroke-linecap="round"
      stroke-linejoin="round"
    />
  </svg>
);
