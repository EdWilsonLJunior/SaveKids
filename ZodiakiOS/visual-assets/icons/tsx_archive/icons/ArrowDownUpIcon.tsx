import { IconProps } from "../IconProps.js";

export const ArrowDownUpIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor",
  strokeWidth = 1,
  className,
  ...props
}: IconProps) => (
  <svg
    viewBox="0 0 16 16"
    width={width}
    height={height}
    fill="none"
    {...props}
    xmlns="http://www.w3.org/2000/svg"
  >
    <g id="Category=Arrow, Name=Arrow_Down_Up">
      <path
        d="M7.33301 10.6668L5.33301 12.6668M5.33301 12.6668L3.33301 10.6668M5.33301 12.6668V3.3335M8.66634 5.3335L10.6663 3.3335M10.6663 3.3335L12.6663 5.3335M10.6663 3.3335V12.6668"
        stroke={color}
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </g>
  </svg>
);
