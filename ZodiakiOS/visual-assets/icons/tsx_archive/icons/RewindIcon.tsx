import { IconProps } from "../IconProps.js";

export const RewindIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Media, Name=Rewind">
      <path
        id="Vector"
        d="M7 7.99935L13 11.3327V4.66602L7 7.99935ZM7 7.99935V4.66602L1 7.99935L7 11.3327V7.99935Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
