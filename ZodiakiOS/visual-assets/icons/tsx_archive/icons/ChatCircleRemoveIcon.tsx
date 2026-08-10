import { IconProps } from "../IconProps.js";

export const ChatCircleRemoveIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Communication, Name=Chat_Circle_Remove">
      <path
        id="Vector"
        d="M6 8H10M7.99976 14C6.90968 14 5.8875 13.7093 5.00651 13.2012L5.00376 13.1996C4.91856 13.1504 4.87579 13.1258 4.83529 13.1146C4.79718 13.1041 4.76317 13.1005 4.72373 13.1032C4.68142 13.1061 4.63692 13.1209 4.54936 13.1501L3.01172 13.6626L3.0077 13.6641C2.6847 13.7718 2.52321 13.8256 2.41536 13.7871C2.32112 13.7535 2.24653 13.6792 2.21292 13.5849C2.17438 13.4768 2.22845 13.3146 2.33659 12.9902L2.33724 12.9882L2.84979 11.4505C2.87907 11.3627 2.89335 11.3187 2.89625 11.2764C2.89895 11.2369 2.896 11.2027 2.88547 11.1646C2.87431 11.1242 2.84965 11.0814 2.80076 10.9967L2.7988 10.9933C2.2907 10.1123 2 9.09008 2 8C2 4.68629 4.68629 2 8 2C11.3137 2 14 4.68629 14 8C14 11.3137 11.3135 14 7.99976 14Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
