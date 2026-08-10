import { IconProps } from "../IconProps.js";

export const CheckAllIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Check_All">
      <path
        id="Vector"
        d="M5.33333 8.32259L8.16176 11.151L13.818 5.49414M2 8.32259L4.82843 11.151M10.4853 5.49414L8.33333 7.66575"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
