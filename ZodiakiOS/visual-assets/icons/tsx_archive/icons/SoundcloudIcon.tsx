import { IconProps } from "../IconProps.js";

export const SoundcloudIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Social Media, Name=Soundcloud">
      <path
        id="Vector"
        d="M5.77745 5.03688V11.7035M3.55523 11.7035V6.51836M1.33301 10.9628V9.48133M11.7034 7.25911H12.4441C13.4663 7.25911 14.6663 8.20281 14.6663 9.48133C14.6663 10.7087 13.5552 11.7035 12.4441 11.7035H7.99967V4.29614C10.2219 4.29614 11.333 5.40725 11.7034 7.25911Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
