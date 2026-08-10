import { IconProps } from "../IconProps.js";

export const UndoIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Undo">
      <path
        id="Vector"
        d="M6.66536 5.33333H3.33203V2M3.52604 10.9046C4.14726 11.8612 5.05879 12.5935 6.12682 12.9938C7.19485 13.3942 8.36337 13.4416 9.46033 13.1291C10.5573 12.8167 11.5249 12.1609 12.2216 11.2578C12.9184 10.3547 13.3074 9.25201 13.3313 8.11165C13.3552 6.9713 13.0128 5.85334 12.3545 4.92188C11.6962 3.99041 10.7564 3.29467 9.6735 2.93652C8.59058 2.57838 7.42142 2.57666 6.33757 2.93197C5.25371 3.28727 4.31242 3.98063 3.65169 4.91037"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
