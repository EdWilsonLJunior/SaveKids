import { IconProps } from "../IconProps.js";

export const ArrowUndoDownLeftIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Undo_Down_Left">
      <path
        id="Vector"
        d="M4.66667 7.33398L2 10.0007M2 10.0007L4.66667 12.6673M2 10.0007H10.6667C12.5076 10.0007 14 8.50827 14 6.66732C14 4.82637 12.5076 3.33398 10.6667 3.33398H7.33333"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
