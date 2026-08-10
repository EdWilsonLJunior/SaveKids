import { IconProps } from "../IconProps.js";

export const RainbowIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Environment, Name=Rainbow">
      <path
        id="Vector"
        d="M2 11.3333V10C2 6.68629 4.68629 4 8 4C11.3137 4 14 6.68629 14 10V11.3333M4 11.3333V10C4 7.79086 5.79086 6 8 6C10.2091 6 12 7.79086 12 10V11.3333M6 11.3333V10C6 8.89543 6.89543 8 8 8C9.10457 8 10 8.89543 10 10V11.3333"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
