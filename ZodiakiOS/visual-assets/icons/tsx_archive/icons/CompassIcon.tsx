import { IconProps } from "../IconProps.js";

export const CompassIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Navigation, Name=Compass">
      <g id="Vector">
        <path
          d="M2 8C2 11.3137 4.68629 14 8 14C11.3137 14 14 11.3137 14 8C14 4.68629 11.3137 2 8 2C4.68629 2 2 4.68629 2 8Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
        <path
          d="M7 7L10.6667 5.33333L9 9L5.33333 10.6667L7 7Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
      </g>
    </g>
  </svg>
);
