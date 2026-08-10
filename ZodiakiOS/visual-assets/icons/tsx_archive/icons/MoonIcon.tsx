import { IconProps } from "../IconProps.js";

export const MoonIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Environment, Name=Moon">
      <path
        id="Vector"
        d="M6 4.00065C6 7.31436 8.68629 10.0007 12 10.0007C12.6062 10.0007 13.1913 9.91099 13.7429 9.74382C12.9962 12.2075 10.7075 14.0006 8 14.0006C4.68629 14.0006 2 11.3145 2 8.00074C2 5.29321 3.79338 3.00454 6.25707 2.25781C6.08989 2.80939 6 3.39448 6 4.00065Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
