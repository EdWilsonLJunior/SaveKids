import { IconProps } from "../IconProps.js";

export const AddPlusIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor",
  className,
  strokeWidth = "1",
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Add_Plus">
      <path
        id="Vector"
        d="M4 8H8M8 8H12M8 8V12M8 8V4"
        stroke={color}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
