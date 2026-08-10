import { IconProps } from "../IconProps.js";

export const ItalicIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Italic">
      <path
        id="Vector"
        d="M5.33203 12.6673H6.66536M6.66536 12.6673H7.9987M6.66536 12.6673L9.33203 3.33398M7.9987 3.33398H9.33203M9.33203 3.33398H10.6654"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
