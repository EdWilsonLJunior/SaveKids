import { IconProps } from "../IconProps.js";

export const UnfoldMoreIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Unfold_More">
      <path
        id="Vector"
        d="M10.6654 10.0007L7.9987 12.6673L5.33203 10.0007M5.33203 6.00065L7.9987 3.33398L10.6654 6.00065"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
