import { IconProps } from "../IconProps.js";

export const ParagraphIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Paragraph">
      <path
        id="Vector"
        d="M8.0013 3.33398V8.66732M8.0013 3.33398H10.668M8.0013 3.33398H7.33464C5.86188 3.33398 4.66797 4.52789 4.66797 6.00065C4.66797 7.47341 5.86188 8.66732 7.33464 8.66732H8.0013M8.0013 8.66732V12.6673M10.668 3.33398V12.6673M10.668 3.33398H11.3346"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
