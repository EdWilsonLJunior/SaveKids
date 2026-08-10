import { IconProps } from "../IconProps.js";

export const ShowIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Show">
      <g id="Vector">
        <path
          d="M2.39218 9.18587C3.57847 10.3652 5.64733 11.9999 8.0011 11.9999C10.3549 11.9999 12.4233 10.3652 13.6096 9.18587C13.9225 8.87484 14.0795 8.71879 14.1791 8.41341C14.2502 8.19552 14.2502 7.80449 14.1791 7.5866C14.0795 7.28121 13.9225 7.12513 13.6096 6.81407C12.4233 5.63472 10.3549 4 8.0011 4C5.64733 4 3.57847 5.63472 2.39218 6.81407C2.07907 7.12535 1.9225 7.2811 1.82284 7.5866C1.75176 7.80449 1.75176 8.19552 1.82284 8.41341C1.9225 8.71891 2.07907 8.8746 2.39218 9.18587Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
        <path
          d="M6.66764 8C6.66764 8.73638 7.2646 9.33333 8.00098 9.33333C8.73736 9.33333 9.33431 8.73638 9.33431 8C9.33431 7.26362 8.73736 6.66667 8.00098 6.66667C7.2646 6.66667 6.66764 7.26362 6.66764 8Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
      </g>
    </g>
  </svg>
);
