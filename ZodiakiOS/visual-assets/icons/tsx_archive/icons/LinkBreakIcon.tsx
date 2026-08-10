import { IconProps } from "../IconProps.js";

export const LinkBreakIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Link_Break">
      <path
        id="Vector"
        d="M10.668 13.3327V11.9993M12.0013 10.666H13.3346M4.70127 7.52799L3.75846 8.4708C2.71707 9.5122 2.71774 11.2004 3.75914 12.2418C4.80054 13.2832 6.4885 13.2835 7.5299 12.2421L8.47301 11.2992M4.0013 5.33268H2.66797M5.33464 2.66602V3.99935M7.52995 4.69964L8.47276 3.75684C9.51416 2.71544 11.2024 2.71514 12.2438 3.75653C13.2852 4.79793 13.2849 6.48655 12.2435 7.52795L11.3008 8.47073"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
