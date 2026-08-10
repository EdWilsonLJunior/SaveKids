import { IconProps } from "../IconProps.js";

export const CoffeeIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Environment, Name=Coffee">
      <path
        id="Vector"
        d="M2.66797 13.3333H7.29682M7.29682 13.3333H7.37245M7.29682 13.3333C7.30941 13.3334 7.32202 13.3335 7.33464 13.3335C7.34725 13.3335 7.35986 13.3334 7.37245 13.3333M7.29682 13.3333C4.7369 13.313 2.66797 11.2312 2.66797 8.66652V5.94857C2.66797 5.6087 2.94334 5.33333 3.2832 5.33333H11.3858C11.7256 5.33333 12.0013 5.6087 12.0013 5.94857V6M7.37245 13.3333H12.0013M7.37245 13.3333C9.93237 13.313 12.0013 11.2312 12.0013 8.66652M12.0013 6H13.0013C13.9218 6 14.668 6.74619 14.668 7.66667C14.668 8.58714 13.9218 9.33333 13.0013 9.33333H12.0013V8.66652M12.0013 6V8.66652M10.0013 2L9.33464 3.33333M8.0013 2L7.33464 3.33333M6.0013 2L5.33464 3.33333"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
