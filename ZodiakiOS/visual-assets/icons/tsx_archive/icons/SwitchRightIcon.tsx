import { IconProps } from "../IconProps.js";

export const SwitchRightIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Switch_Right">
      <g id="Vector">
        <path
          d="M5.33203 12H10.6654C12.8745 12 14.6654 10.2091 14.6654 8C14.6654 5.79086 12.8745 4 10.6654 4H5.33203C3.12289 4 1.33203 5.79086 1.33203 8C1.33203 10.2091 3.12289 12 5.33203 12Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
        <path
          d="M10.6654 6C9.56079 6 8.66536 6.89543 8.66536 8C8.66536 9.10457 9.56079 10 10.6654 10C11.7699 10 12.6654 9.10457 12.6654 8C12.6654 6.89543 11.7699 6 10.6654 6Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
      </g>
    </g>
  </svg>
);
