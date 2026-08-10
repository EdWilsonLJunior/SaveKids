import { IconProps } from "../IconProps.js";

export const UserCheckIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=User, Name=User_Check">
      <path
        id="Vector"
        d="M10 12.666C10 11.1933 8.20914 9.99935 6 9.99935C3.79086 9.99935 2 11.1933 2 12.666M14 6.66602L11.3333 9.33268L10 7.99935M6 7.99935C4.52724 7.99935 3.33333 6.80544 3.33333 5.33268C3.33333 3.85992 4.52724 2.66602 6 2.66602C7.47276 2.66602 8.66667 3.85992 8.66667 5.33268C8.66667 6.80544 7.47276 7.99935 6 7.99935Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
