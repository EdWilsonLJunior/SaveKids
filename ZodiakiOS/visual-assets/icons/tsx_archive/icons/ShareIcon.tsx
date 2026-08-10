import { IconProps } from "../IconProps.js";

export const ShareIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Communication, Name=Share">
      <path
        id="Vector"
        d="M8.66679 2.66675V5.33341C4.28346 6.01875 2.65346 9.85875 2.00013 13.3334C1.97546 13.4707 5.58946 9.35875 8.66679 9.33341V12.0001L14.0001 7.33341L8.66679 2.66675Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
