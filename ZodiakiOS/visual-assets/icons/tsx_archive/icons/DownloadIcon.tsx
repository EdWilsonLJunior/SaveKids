import { IconProps } from "../IconProps.js";

export const DownloadIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Download">
      <path
        id="Vector"
        d="M4 14H12M8 2V11.3333M8 11.3333L11.3333 8M8 11.3333L4.66667 8"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
