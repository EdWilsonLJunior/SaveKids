import { IconProps } from "../IconProps.js";

export const ListOrderedIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=List_Ordered">
      <path
        id="Vector"
        d="M6.66797 11.3327H13.3346M2.66797 10.4562V10.3327C2.66797 9.7804 3.11568 9.33268 3.66797 9.33268H3.695C4.23235 9.33268 4.66811 9.76831 4.66811 10.3057C4.66811 10.5396 4.5921 10.7673 4.45175 10.9544L2.66797 13.3328L4.66797 13.3327M6.66797 7.99935H13.3346M6.66797 4.66602H13.3346M2.66797 3.33268L4.0013 2.66602V6.66602"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
