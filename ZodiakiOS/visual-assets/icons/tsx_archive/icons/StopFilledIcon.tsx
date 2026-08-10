import { IconProps } from "../IconProps.js";

export const StopFilledIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Media, Name=Stop Filled">
      <path
        id="Vector"
        d="M3.33203 5.46745V10.5341C3.33203 11.2809 3.33203 11.6537 3.47736 11.9389C3.60519 12.1898 3.80901 12.3943 4.0599 12.5221C4.34483 12.6673 4.71803 12.6673 5.4633 12.6673H10.5344C11.2797 12.6673 11.6523 12.6673 11.9373 12.5221C12.1882 12.3943 12.3924 12.1898 12.5202 11.9389C12.6654 11.654 12.6654 11.2813 12.6654 10.536V5.46526C12.6654 4.71998 12.6654 4.34679 12.5202 4.06185C12.3924 3.81097 12.1882 3.60714 11.9373 3.47931C11.6521 3.33398 11.2789 3.33398 10.5322 3.33398H5.46549C4.71876 3.33398 4.34511 3.33398 4.0599 3.47931C3.80901 3.60714 3.60519 3.81097 3.47736 4.06185C3.33203 4.34706 3.33203 4.72071 3.33203 5.46745Z"
        fill={color}
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
