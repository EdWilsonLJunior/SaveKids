import { IconProps } from "../IconProps.js";

export const MapIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Navigation, Name=Map">
      <path
        id="Vector"
        d="M10 4V14M10 4L14 2V12L10 14M10 4L6 2M10 14L6 12M6 12L2 14V4L6 2M6 12V2"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
