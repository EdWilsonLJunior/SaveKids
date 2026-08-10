import { IconProps } from "../IconProps.js";

export const TableRemoveIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Table_Remove">
      <path
        id="Vector"
        d="M7.33333 2.66602H10.5335C11.2802 2.66602 11.6534 2.66602 11.9386 2.81134C12.1895 2.93917 12.3937 3.143 12.5215 3.39388C12.6667 3.67882 12.6667 4.05201 12.6667 4.79729V5.99948L7.33337 5.99941M7.33333 2.66602H4.13346C3.38673 2.66602 3.01308 2.66602 2.72786 2.81134C2.47698 2.93917 2.27316 3.143 2.14532 3.39388C2 3.6791 2 4.05274 2 4.79948V5.99935M7.33333 2.66602L7.33337 5.99941M2 5.99935V9.99935M2 5.99935L7.33337 5.99941M2 9.99935V11.1995C2 11.9462 2 12.3194 2.14532 12.6046C2.27316 12.8555 2.47698 13.0597 2.72786 13.1875C3.0128 13.3327 3.386 13.3327 4.13127 13.3327H7.33346L7.33337 5.99941M2 9.99935H7.33333M10 10.666H14"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
