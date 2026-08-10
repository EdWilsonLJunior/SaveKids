import { IconProps } from "../IconProps.js";

export const DataIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=System, Name=Data">
      <path
        id="Vector"
        d="M12 7.99935V11.3327C12 12.4373 10.2091 13.3327 8 13.3327C5.79086 13.3327 4 12.4373 4 11.3327V7.99935M12 7.99935V4.66602M12 7.99935C12 9.10392 10.2091 9.99935 8 9.99935C5.79086 9.99935 4 9.10392 4 7.99935M12 4.66602C12 3.56145 10.2091 2.66602 8 2.66602C5.79086 2.66602 4 3.56145 4 4.66602M12 4.66602C12 5.77059 10.2091 6.66602 8 6.66602C5.79086 6.66602 4 5.77059 4 4.66602M4 7.99935V4.66602"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
