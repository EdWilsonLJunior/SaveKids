import { IconProps } from "../IconProps.js";

export const SortAscendingIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Sort_Ascending">
      <path
        id="Vector"
        d="M2.66797 11.3327H6.66797M2.66797 7.99935H8.66797M12.0013 7.33268V12.666M12.0013 12.666L14.0013 10.666M12.0013 12.666L10.0013 10.666M2.66797 4.66602H10.668"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
