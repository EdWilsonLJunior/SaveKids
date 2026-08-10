import { IconProps } from "../IconProps.js";

export const MoveIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Move">
      <path
        id="Vector"
        d="M8 14V8M8 14L10 12M8 14L6 12M8 8V2M8 8H2M8 8H14M8 2L6 4M8 2L10 4M2 8L4 10M2 8L4 6M14 8L12 6M14 8L12 10"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
