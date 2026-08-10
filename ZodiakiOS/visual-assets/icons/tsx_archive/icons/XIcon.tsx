import { IconProps } from "../IconProps.js";

export const XIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Social Media, Name=X">
      <path
        id="Vector"
        d="M11.5046 2.84253H13.3061L9.37032 7.34086L14.0004 13.4621H10.3751L7.53559 9.7496L4.28655 13.4621H2.48395L6.69365 8.65061L2.25195 2.84253H5.96934L8.53601 6.23589L11.5046 2.84253ZM10.8723 12.3838H11.8705L5.42693 3.86418H4.35571L10.8723 12.3838Z"
        fill={color}
      />
    </g>
  </svg>
);
