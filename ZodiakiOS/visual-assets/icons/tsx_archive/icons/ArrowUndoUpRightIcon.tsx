import { IconProps } from "../IconProps.js";

export const ArrowUndoUpRightIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Undo_Up_Right">
      <path
        id="Vector"
        d="M11.3333 8.66732L14 6.00065M14 6.00065L11.3333 3.33398M14 6.00065H5.33333C3.49238 6.00065 2 7.49304 2 9.33398C2 11.1749 3.49238 12.6673 5.33333 12.6673H8.66667"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
