import { IconProps } from "../IconProps.js";

export const PlayFilledIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Media, Name=Play Filled">
      <path
        id="Vector"
        d="M4.33203 11.5558V4.44466C4.33203 3.85828 4.33203 3.56476 4.45543 3.39127C4.56312 3.23985 4.72912 3.14043 4.91341 3.11666C5.12449 3.08944 5.38337 3.2275 5.90039 3.50325L12.5671 7.0588L12.5695 7.05988C13.1409 7.36461 13.4267 7.51705 13.5204 7.72022C13.6022 7.89746 13.6022 8.10205 13.5204 8.27929C13.4265 8.48275 13.14 8.63581 12.5671 8.9414L5.90039 12.497C5.383 12.7729 5.12456 12.9104 4.91341 12.8832C4.72912 12.8594 4.56312 12.76 4.45543 12.6086C4.33203 12.4351 4.33203 12.1421 4.33203 11.5558Z"
        fill={color}
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
