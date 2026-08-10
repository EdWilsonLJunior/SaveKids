import { IconProps } from "../IconProps.js";

export const ListAddIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=List_Add">
      <path
        id="Vector"
        d="M2 11.3327H6.66667M10 10.666H12M12 10.666H14M12 10.666V12.666M12 10.666V8.66602M2 7.99935H9.33333M2 4.66602H9.33333"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
