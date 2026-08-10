import { IconProps } from "../IconProps.js";

export const BoldIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Bold">
      <path
        id="Vector"
        d="M5.33203 8.00065H8.33203M5.33203 8.00065V3.33398H8.33203C9.6207 3.33398 10.6654 4.37865 10.6654 5.66732C10.6654 6.95598 9.6207 8.00065 8.33203 8.00065M5.33203 8.00065V12.6673H8.9987C10.2874 12.6673 11.332 11.6226 11.332 10.334C11.332 9.04532 10.2874 8.00065 8.9987 8.00065H8.33203"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
