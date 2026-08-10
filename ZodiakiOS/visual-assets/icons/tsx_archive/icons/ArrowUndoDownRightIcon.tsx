import { IconProps } from "../IconProps.js";

export const ArrowUndoDownRightIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Undo_Down_Right">
      <path
        id="Vector"
        d="M11.3333 7.33398L14 10.0007M14 10.0007L11.3333 12.6673M14 10.0007H5.33333C3.49238 10.0007 2 8.50827 2 6.66732C2 4.82637 3.49238 3.33398 5.33333 3.33398H8.66667"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
