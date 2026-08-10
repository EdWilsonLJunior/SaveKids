import { IconProps } from "../IconProps.js";

export const ArrowUndoUpLeftIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Arrow, Name=Arrow_Undo_Up_Left">
      <path
        id="Vector"
        d="M4.66667 8.66732L2 6.00065M2 6.00065L4.66667 3.33398M2 6.00065H10.6667C12.5076 6.00065 14 7.49304 14 9.33398C14 11.1749 12.5076 12.6673 10.6667 12.6673H7.33333"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
