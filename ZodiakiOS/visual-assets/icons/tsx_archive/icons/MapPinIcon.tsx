import { IconProps } from "../IconProps.js";

export const MapPinIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Navigation, Name=Map_Pin">
      <g id="Vector">
        <path
          d="M3.33203 6.61523C3.33203 9.84978 6.16168 12.5246 7.41416 13.5501C7.59341 13.6969 7.68411 13.7712 7.81784 13.8088C7.92197 13.8381 8.07523 13.8381 8.17936 13.8088C8.31334 13.7711 8.40341 13.6976 8.58333 13.5502C9.83581 12.5247 12.6653 9.85008 12.6653 6.61553C12.6653 5.39145 12.1737 4.21737 11.2985 3.35181C10.4233 2.48626 9.23643 2 7.99875 2C6.76107 2 5.57404 2.48634 4.69887 3.35189C3.8237 4.21744 3.33203 5.39116 3.33203 6.61523Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
        <path
          d="M6.66536 6C6.66536 6.73638 7.26232 7.33333 7.9987 7.33333C8.73508 7.33333 9.33203 6.73638 9.33203 6C9.33203 5.26362 8.73508 4.66667 7.9987 4.66667C7.26232 4.66667 6.66536 5.26362 6.66536 6Z"
          stroke={color} strokeLinecap="round"
          strokeLinejoin="round"
        />
      </g>
    </g>
  </svg>
);
