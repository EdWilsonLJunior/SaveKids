import { IconProps } from "../IconProps.js";

export const CloudDownloadIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=File, Name=Cloud_Download">
      <path
        id="Vector"
        d="M8.0013 6.00065V10.0007M8.0013 10.0007L10.0013 8.66732M8.0013 10.0007L6.0013 8.66732M15.3346 10.0007C15.3346 8.52789 14.1407 7.33398 12.668 7.33398C12.6522 7.33398 12.6368 7.33412 12.6211 7.3344C12.2978 5.07267 10.3524 3.33398 8.0013 3.33398C6.13687 3.33398 4.5281 4.42734 3.7806 6.00786C2.04268 6.12161 0.667969 7.56719 0.667969 9.33389C0.667969 11.1748 2.16035 12.6674 4.0013 12.6674L12.668 12.6673C14.1407 12.6673 15.3346 11.4734 15.3346 10.0007Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
