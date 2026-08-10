import { IconProps } from "../IconProps.js";

export const ExpandIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Expand">
      <path
        id="Vector"
        d="M6.66536 12.6673H3.33203V9.33398M9.33203 3.33398H12.6654V6.66732"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
