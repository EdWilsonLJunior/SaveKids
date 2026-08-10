import { IconProps } from "../IconProps.js";

export const TrendingDownIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Trending_Down">
      <path
        id="Vector"
        d="M13.3349 11.3327L9.4375 7.37435C9.3675 7.30325 9.33211 7.26763 9.30078 7.23958C8.79454 6.78647 8.02903 6.78647 7.52279 7.23958C7.49145 7.26763 7.45579 7.30322 7.38575 7.37435C7.31572 7.44547 7.28069 7.48106 7.24935 7.50911C6.74311 7.96222 5.97728 7.96222 5.47104 7.5091C5.4397 7.48105 5.40468 7.44549 5.33464 7.37435L2.66797 4.66602M13.3349 11.3327L13.3346 7.33268M13.3349 11.3327H9.33464"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
