import { IconProps } from "../IconProps.js";

export const WindowsIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Social Media, Name=Windows">
      <path
        id="Vector"
        d="M8.00033 3.33313V12.6665M2.66699 7.9998H13.3337M11.867 13.3331L3.86699 12.3331C3.20033 12.2664 2.66699 11.7331 2.66699 11.0664V4.93311C2.66699 4.26645 3.20033 3.73311 3.86699 3.66645L11.867 2.66645C12.667 2.59978 13.3337 3.19978 13.3337 3.93311V11.9998C13.3337 12.7998 12.6003 13.3998 11.867 13.2664V13.3331Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
