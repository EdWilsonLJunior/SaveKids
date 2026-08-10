import { IconProps } from "../IconProps.js";

export const MobileButtonIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=System, Name=Mobile_Button">
      <path
        id="Vector"
        d="M4.66797 4.13346V11.8668C4.66797 12.6135 4.66797 12.9867 4.81329 13.2719C4.94112 13.5228 5.14495 13.727 5.39583 13.8548C5.68077 14 6.05396 14 6.79924 14H9.20336C9.94864 14 10.3213 14 10.6062 13.8548C10.8571 13.727 11.0616 13.5228 11.1895 13.2719C11.3346 12.987 11.3346 12.6143 11.3346 11.8691V4.13127C11.3346 3.386 11.3346 3.0128 11.1895 2.72786C11.0616 2.47698 10.8571 2.27316 10.6062 2.14532C10.321 2 9.94817 2 9.20143 2H6.80143C6.0547 2 5.68105 2 5.39583 2.14532C5.14495 2.27316 4.94112 2.47698 4.81329 2.72786C4.66797 3.01308 4.66797 3.38673 4.66797 4.13346Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
