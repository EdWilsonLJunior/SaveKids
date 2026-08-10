import { IconProps } from "../IconProps.js";

export const NavigationIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Navigation, Name=Navigation" transform="translate(-1 0)">
      <path
        id="Vector"
        d="M13.3503 2.3703L2.81085 5.6132C2.23601 5.79007 2.17066 6.57757 2.7086 6.84654L7.1755 9.07994C7.30452 9.14445 7.40918 9.2491 7.47369 9.37812L9.70702 13.8448C9.97599 14.3827 10.7633 14.3175 10.9402 13.7426L14.1834 3.20324C14.3408 2.69173 13.8618 2.21291 13.3503 2.3703Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
