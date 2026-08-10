import { IconProps } from "../IconProps.js";

export const ArrowDownIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor",
  strokeWidth = "1", className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Down">
      <path
        id="Vector"
        d="M8 3.33398V12.6673M8 12.6673L12 8.66732M8 12.6673L4 8.66732"
        stroke={color}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
