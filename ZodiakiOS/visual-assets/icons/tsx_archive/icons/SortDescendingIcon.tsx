import { IconProps } from "../IconProps.js";

export const SortDescendingIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Sort_Descending">
      <path
        id="Vector"
        d="M2.66797 11.334H10.668M2.66797 8.00065H8.66797M2.66797 4.66732H6.66797M12.0013 8.66732V3.33398M12.0013 3.33398L14.0013 5.33398M12.0013 3.33398L10.0013 5.33398"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
