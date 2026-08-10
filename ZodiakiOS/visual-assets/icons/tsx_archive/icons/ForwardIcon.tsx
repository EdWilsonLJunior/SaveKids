import { IconProps } from "../IconProps.js";

export const ForwardIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Media, Name=Forward">
      <path
        id="Vector"
        d="M9 7.99935V4.66602L15 7.99935L9 11.3327V7.99935ZM9 7.99935L3 11.3327V4.66602L9 7.99935Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
