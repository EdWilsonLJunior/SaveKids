import { IconProps } from "../IconProps.js";

export const BotIcon = ({
  width = "16px",
  height = "16px",
  color = "currentColor",
  className,
  strokeWidth = "1",
  ...props
}: IconProps) => (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    width={width}
    height={height}
    viewBox="0 0 16 16"
    fill="none"
    {...props}
  >
    <g id="Category=AI, Name=Bot">
      <path
        d="M6.6293 8.68513H5.25893M10.7404 8.68513H9.37005M8.68486 11.4259H7.31449M1.83301 10.7407L1.83301 7.99991M14.1663 10.7407V7.99991M7.99967 2.51846V4.57402M4.57375 14.1666H11.4256C12.5609 14.1666 13.4812 13.2463 13.4812 12.111V7.31474C13.4812 6.17949 12.5609 5.25919 11.4256 5.25919H4.57375C3.4385 5.25919 2.51819 6.17949 2.51819 7.31474V12.111C2.51819 13.2463 3.4385 14.1666 4.57375 14.1666ZM8.68486 2.49992C8.68486 2.86811 8.38638 3.16659 8.01819 3.16659C7.65 3.16659 7.35153 2.86811 7.35153 2.49992C7.35153 2.13173 7.65 1.83325 8.01819 1.83325C8.38638 1.83325 8.68486 2.13173 8.68486 2.49992Z"
        stroke={color}
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </g>
  </svg>
);
