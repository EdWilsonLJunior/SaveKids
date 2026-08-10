import { IconProps } from "../IconProps.js";

export const SkipBackIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Media, Name=Skip_Back">
      <path
        id="Vector"
        d="M4.66797 3.33398V12.6673M12.0013 7.04818V8.95309C12.0013 10.1711 12.0011 10.7802 11.7454 11.1312C11.5224 11.4372 11.1799 11.6337 10.8031 11.6722C10.3712 11.7162 9.84505 11.4093 8.79294 10.7956L7.15499 9.84008C6.12036 9.23655 5.60279 8.93464 5.42839 8.54102C5.27598 8.19705 5.27598 7.80478 5.42839 7.46082C5.60308 7.06654 6.12208 6.76373 7.16016 6.15818L8.79294 5.20573L8.79431 5.20494C9.84552 4.59174 10.3713 4.28501 10.8031 4.32902C11.1799 4.36743 11.5224 4.56436 11.7454 4.87044C12.0011 5.22139 12.0013 5.83015 12.0013 7.04818Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
