import { IconProps } from "../IconProps.js";

export const CloudOffIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=File, Name=Cloud_Off">
      <path
        id="Vector"
        d="M12.668 12.6673H4.0013C2.16035 12.6673 0.667969 11.1749 0.667969 9.33398C0.667969 7.56729 2.04238 6.12157 3.78031 6.00781C4.00428 5.53424 4.30619 5.10449 4.66856 4.7347M12.668 12.6673L3.33464 3.33398M12.668 12.6673L14.0013 14.0007M6.66797 3.52724C7.09044 3.4015 7.53799 3.33398 8.0013 3.33398C10.3524 3.33398 12.2975 5.07267 12.6208 7.3344C12.6365 7.33412 12.6529 7.33398 12.6686 7.33398C14.1414 7.33398 15.3343 8.52789 15.3343 10.0007C15.3343 10.6313 15.116 11.2108 14.75 11.6673"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
