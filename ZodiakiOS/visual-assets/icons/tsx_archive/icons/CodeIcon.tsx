import { IconProps } from "../IconProps.js";

export const CodeIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=System, Name=Code">
      <path
        id="Vector"
        d="M10.0013 4.66602L13.3346 7.99935L10.0013 11.3327M6.0013 11.3327L2.66797 7.99935L6.0013 4.66602"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
