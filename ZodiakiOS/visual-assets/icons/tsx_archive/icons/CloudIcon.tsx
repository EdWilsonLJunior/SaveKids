import { IconProps } from "../IconProps.js";

export const CloudIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=File, Name=Cloud">
      <path
        id="Vector"
        d="M12.668 7.33398C14.1407 7.33398 15.3346 8.52789 15.3346 10.0007C15.3346 11.4734 14.1407 12.6673 12.668 12.6673L4.0013 12.6674C2.16035 12.6674 0.667969 11.1748 0.667969 9.33389C0.667969 7.56719 2.04268 6.12161 3.7806 6.00786C4.5281 4.42734 6.13687 3.33398 8.0013 3.33398C10.3524 3.33398 12.2978 5.07267 12.6211 7.3344C12.6368 7.33412 12.6522 7.33398 12.668 7.33398Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
