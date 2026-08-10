import { IconProps } from "../IconProps.js";

export const GooglePodcastsIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Social Media, Name=Google-podcasts">
      <path
        id="Vector"
        d="M8.00033 2V3.33333M8.00033 12.6667V14M8.00033 5.33333V10.6667M5.33366 11.3333V12.6667M2.66699 7.33333V8.66667M13.3337 7.33333V8.66667M5.33366 3.33333V8.66667M10.667 4.66667V3.33333M10.667 12.6667V7.33333"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
