import { IconProps } from "../IconProps.js";

export const ListChecklistIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=List_Checklist">
      <path
        id="Vector"
        d="M7.33464 11.334H13.3346M5.33464 10.0007L3.66797 12.0007L2.66797 11.334M7.33464 8.00065H13.3346M5.33464 6.66732L3.66797 8.66732L2.66797 8.00065M7.33464 4.66732H13.3346M5.33464 3.33398L3.66797 5.33398L2.66797 4.66732"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
