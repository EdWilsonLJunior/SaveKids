import { IconProps } from "../IconProps.js";

export const ListRemoveIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=List_Remove">
      <path
        id="Vector"
        d="M2 11.3327H6.66667M10 10.666H14M2 7.99935H9.33333M2 4.66602H9.33333"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
