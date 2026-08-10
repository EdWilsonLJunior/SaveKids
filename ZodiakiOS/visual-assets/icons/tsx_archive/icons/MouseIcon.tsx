import { IconProps } from "../IconProps.js";

export const MouseIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=System, Name=Mouse">
      <path
        id="Vector"
        d="M8 6.66667V4.66667M12 6V10C12 12.2091 10.2091 14 8 14C5.79086 14 4 12.2091 4 10V6C4 3.79086 5.79086 2 8 2C10.2091 2 12 3.79086 12 6Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
