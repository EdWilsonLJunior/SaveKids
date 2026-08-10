import { IconProps } from "../IconProps.js";

export const ArrowLeftRightIcon = ({
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
    <g id="Category=Arrow, Name=Arrow_Left_Right">
      <path
        d="M10.6663 8.66683L12.6663 10.6668M12.6663 10.6668L10.6663 12.6668M12.6663 10.6668H3.33301M5.33301 7.3335L3.33301 5.3335M3.33301 5.3335L5.33301 3.3335M3.33301 5.3335H12.6663"
        stroke={color}
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </g>
  </svg>
);
