import { IconProps } from "../IconProps.js";

export const CreditCardIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Credit_Card">
      <path
        id="Vector"
        d="M2 7.33398V10.5341C2 11.2809 2 11.654 2.14532 11.9392C2.27316 12.1901 2.47698 12.3943 2.72786 12.5221C3.0128 12.6673 3.386 12.6673 4.13127 12.6673H11.8687C12.614 12.6673 12.9867 12.6673 13.2716 12.5221C13.5225 12.3943 13.727 12.1901 13.8548 11.9392C14 11.6543 14 11.2816 14 10.5364V7.33398M2 7.33398V6.00065M2 7.33398H14M2 6.00065V5.46745C2 4.72071 2 4.34706 2.14532 4.06185C2.27316 3.81097 2.47698 3.60714 2.72786 3.47931C3.01308 3.33398 3.38673 3.33398 4.13346 3.33398H11.8668C12.6135 3.33398 12.9864 3.33398 13.2716 3.47931C13.5225 3.60714 13.727 3.81097 13.8548 4.06185C14 4.34679 14 4.71998 14 5.46526V6.00065M2 6.00065H14M4.66667 10.0007H7.33333M14 7.33398V6.00065"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
