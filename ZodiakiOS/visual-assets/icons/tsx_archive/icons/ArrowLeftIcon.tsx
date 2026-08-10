import { IconProps } from "../IconProps.js";

export const ArrowLeftIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Left">
      <path
        id="Vector"
        d="M12.6654 8H3.33203M3.33203 8L7.33203 12M3.33203 8L7.33203 4"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
