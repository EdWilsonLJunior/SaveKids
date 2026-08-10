import { IconProps } from "../IconProps.js";

export const ChartPieIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Chart_Pie">
      <path
        id="Vector"
        d="M8 2C4.68629 2 2 4.68629 2 8C2 11.3137 4.68629 14 8 14C11.3137 14 14 11.3137 14 8M8 2C11.3137 2 14 4.68629 14 8M8 2V8M14 8H8M12 12.3333L8 8"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
