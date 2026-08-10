import { IconProps } from "../IconProps.js";

export const AlarmIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor",
  strokeWidth = "1", className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Calendar, Name=Alarm">
      <path
        id="Vector"
        d="M8 4.66732V8.00065H11.3333M14.0024 3.04808L11.9596 1.33398M4.04279 1.33398L2 3.04808M8 13.334C5.05448 13.334 2.66667 10.9462 2.66667 8.00065C2.66667 5.05513 5.05448 2.66732 8 2.66732C10.9455 2.66732 13.3333 5.05513 13.3333 8.00065C13.3333 10.9462 10.9455 13.334 8 13.334Z"
        stroke={color}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
