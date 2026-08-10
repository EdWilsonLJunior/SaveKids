import { IconProps } from "../IconProps.js";

export const SwitchLeftIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Switch_Left">
      <g id="Vector">
        <path
          d="M5.33203 12H10.6654C12.8745 12 14.6654 10.2091 14.6654 8C14.6654 5.79086 12.8745 4 10.6654 4H5.33203C3.12289 4 1.33203 5.79086 1.33203 8C1.33203 10.2091 3.12289 12 5.33203 12Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
        <path
          d="M5.33203 6C4.22746 6 3.33203 6.89543 3.33203 8C3.33203 9.10457 4.22746 10 5.33203 10C6.4366 10 7.33203 9.10457 7.33203 8C7.33203 6.89543 6.4366 6 5.33203 6Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
      </g>
    </g>
  </svg>
);
