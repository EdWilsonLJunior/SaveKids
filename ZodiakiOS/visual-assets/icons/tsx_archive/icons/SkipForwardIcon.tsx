import { IconProps } from "../IconProps.js";

export const SkipForwardIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Media, Name=Skip_Forward">
      <path
        id="Vector"
        d="M11.3333 3.33398V12.6673M4 7.04818V8.95309C4 10.1711 4 10.7802 4.2557 11.1312C4.47871 11.4372 4.82116 11.6337 5.19792 11.6722C5.62989 11.7162 6.15622 11.4093 7.20833 10.7956L8.84111 9.8431L8.84675 9.83983C9.88109 9.23647 10.3986 8.93458 10.573 8.54102C10.7254 8.19705 10.7254 7.80478 10.573 7.46082C10.3983 7.06654 9.87919 6.76373 8.84111 6.15818L7.20833 5.20573C6.15623 4.592 5.62989 4.28499 5.19792 4.32902C4.82116 4.36743 4.47871 4.56436 4.2557 4.87044C4 5.22139 4 5.83015 4 7.04818Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
