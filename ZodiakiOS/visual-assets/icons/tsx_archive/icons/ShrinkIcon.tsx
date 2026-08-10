import { IconProps } from "../IconProps.js";

export const ShrinkIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Shrink">
      <path
        id="Vector"
        d="M3.33203 9.33398H6.66536V12.6673M12.6654 6.66732H9.33203V3.33398"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
