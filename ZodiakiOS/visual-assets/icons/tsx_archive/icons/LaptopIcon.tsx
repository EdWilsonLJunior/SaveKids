import { IconProps } from "../IconProps.js";

export const LaptopIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=System, Name=Laptop">
      <path
        id="Vector"
        d="M2.66536 11.334H2.33203C1.77975 11.334 1.33203 11.7817 1.33203 12.334C1.33203 12.8863 1.77975 13.334 2.33203 13.334H13.6654C14.2176 13.334 14.6654 12.8863 14.6654 12.334C14.6654 11.7817 14.2176 11.334 13.6654 11.334H13.332M2.66536 11.334H13.332M2.66536 11.334V5.46745C2.66536 4.72071 2.66536 4.34706 2.81069 4.06185C2.93852 3.81097 3.14235 3.60714 3.39323 3.47931C3.67844 3.33398 4.05209 3.33398 4.79883 3.33398H11.1988C11.9456 3.33398 12.3184 3.33398 12.6036 3.47931C12.8545 3.60714 13.059 3.81097 13.1868 4.06185C13.332 4.34679 13.332 4.71998 13.332 5.46526V11.334"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
