import { IconProps } from "../IconProps.js";

export const KeyboardIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=System, Name=Keyboard">
      <path
        id="Vector"
        d="M11.9987 10H12.6654M5.9987 10H9.9987M3.9987 10H3.33203M3.33203 8H12.6654M3.33203 6H12.6654M1.33203 9.8668V6.13346C1.33203 5.38673 1.33203 5.01308 1.47736 4.72786C1.60519 4.47698 1.80901 4.27316 2.0599 4.14532C2.34511 4 2.71876 4 3.46549 4H12.5322C13.2789 4 13.6517 4 13.937 4.14532C14.1878 4.27316 14.3924 4.47698 14.5202 4.72786C14.6654 5.0128 14.6654 5.386 14.6654 6.13127V9.86873C14.6654 10.614 14.6654 10.9867 14.5202 11.2716C14.3924 11.5225 14.1878 11.727 13.937 11.8548C13.652 12 13.2794 12 12.5341 12H3.4633C2.71803 12 2.34483 12 2.0599 11.8548C1.80901 11.727 1.60519 11.5225 1.47736 11.2716C1.33203 10.9864 1.33203 10.6135 1.33203 9.8668Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
