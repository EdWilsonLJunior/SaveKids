import { IconProps } from "../IconProps.js";

export const FlagIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Navigation, Name=Flag">
      <path
        id="Vector"
        d="M2.66797 14V10.4581M2.66797 10.4581C6.54676 7.42514 9.45585 13.4908 13.3346 10.4579V2.87565C9.45585 5.90856 6.54676 -0.157402 2.66797 2.87551V10.4581Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
