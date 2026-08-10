import { IconProps } from "../IconProps.js";

export const RedoIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Redo">
      <path
        id="Vector"
        d="M9.3345 5.33333H12.6678V2M12.474 10.9046C11.8528 11.8612 10.9413 12.5935 9.87324 12.9938C8.80522 13.3942 7.63688 13.4416 6.53991 13.1291C5.44294 12.8167 4.47524 12.1609 3.77851 11.2578C3.08179 10.3547 2.69303 9.25201 2.66914 8.11165C2.64525 6.9713 2.98732 5.85334 3.64562 4.92188C4.30392 3.99041 5.24353 3.29467 6.32645 2.93652C7.40937 2.57838 8.5787 2.57666 9.66255 2.93197C10.7464 3.28727 11.6878 3.98063 12.3486 4.91037"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
