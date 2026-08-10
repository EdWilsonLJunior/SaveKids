import { IconProps } from "../IconProps.js";

export const LayersIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Layers">
      <path
        id="Vector"
        d="M14 8.00065L8 12.0007L2 8.00065M14 10.6673L8 14.6673L2 10.6673M14 5.33398L8 9.33398L2 5.33398L8 1.33398L14 5.33398Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
