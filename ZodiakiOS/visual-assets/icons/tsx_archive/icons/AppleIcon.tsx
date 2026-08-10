import { IconProps } from "../IconProps.js";

export const AppleIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor",
  strokeWidth = "1", className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Social Media, Name=Apple">
      <g id="Vector">
        <path
          d="M5.71461 4.9521C3.4289 4.9521 2.66699 7.23782 2.66699 9.14258C2.66699 11.4283 4.1908 14.8569 5.71461 14.8569C6.54356 14.8218 6.99385 14.4759 8.00033 14.4759C8.99994 14.4759 9.14318 14.8569 10.286 14.8569C11.4289 14.8569 13.3337 12.5711 13.3337 11.0473C13.3123 11.0397 11.4502 10.7403 11.4289 8.76163C11.4144 7.10829 13.2697 6.51096 13.3337 6.47591C12.5542 5.33915 11.0853 4.98029 10.667 4.9521C9.57518 4.86753 8.5108 5.71401 8.00033 5.71401C7.48223 5.71401 6.55271 4.9521 5.71461 4.9521Z"
          stroke={color}
          strokeLinecap="round"
          strokeLinejoin="round"
        />
        <path
          d="M8.00033 2.66639C8.40447 2.66639 8.79205 2.50584 9.07782 2.22007C9.36359 1.9343 9.52414 1.54672 9.52414 1.14258C9.12 1.14258 8.73241 1.30312 8.44664 1.58889C8.16087 1.87466 8.00033 2.26225 8.00033 2.66639Z"
          stroke={color}
          strokeLinecap="round"
          strokeLinejoin="round"
        />
      </g>
    </g>
  </svg>
);
