import { IconProps } from "../IconProps.js";

export const FigmaIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Social Media, Name=Figma">
      <path
        id="Vector"
        d="M6 10H8M6 10C4.89543 10 4 10.8954 4 12C4 13.1046 4.89543 14 6 14C7.10457 14 8 13.1046 8 12V10M6 10C4.89543 10 4 9.10457 4 8C4 6.89543 4.89543 6 6 6M8 10V8M6 6H8M6 6C4.89543 6 4 5.10457 4 4C4 2.89543 4.89543 2 6 2H8M8 6V8M8 6V2M8 6H10M8 8C8 9.10457 8.89543 10 10 10C11.1046 10 12 9.10457 12 8C12 6.89543 11.1046 6 10 6M8 8C8 6.89543 8.89543 6 10 6M8 2H10C11.1046 2 12 2.89543 12 4C12 5.10457 11.1046 6 10 6"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
