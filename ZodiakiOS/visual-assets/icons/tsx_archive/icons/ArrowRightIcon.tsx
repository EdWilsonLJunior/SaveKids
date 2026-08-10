import { IconProps } from "../IconProps.js";

export const ArrowRightIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor",
  strokeWidth = 1,
  className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Right">
      <path
        id="Vector"
        d="M3.33203 8H12.6654M12.6654 8L8.66536 4M12.6654 8L8.66536 12"
        stroke={color}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
