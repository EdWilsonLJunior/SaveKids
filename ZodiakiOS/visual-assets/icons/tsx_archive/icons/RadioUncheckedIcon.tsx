import { IconProps } from "../IconProps.js";

export const RadioUncheckedIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Radio_Unchecked">
      <path
        id="Vector"
        d="M8.0013 2.66602C5.05578 2.66602 2.66797 5.05383 2.66797 7.99935C2.66797 10.9449 5.05578 13.3327 8.0013 13.3327C10.9468 13.3327 13.3346 10.9449 13.3346 7.99935C13.3346 5.05383 10.9468 2.66602 8.0013 2.66602Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
