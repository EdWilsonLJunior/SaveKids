import { IconProps } from "../IconProps.js";

export const ListCheckIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=List_Check">
      <path
        id="Vector"
        d="M2.66797 11.3327H7.33464M13.3346 9.33268L10.668 11.9993L9.33464 10.666M2.66797 7.99935H10.0013M2.66797 4.66602H10.0013"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
