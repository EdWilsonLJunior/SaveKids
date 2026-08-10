import { IconProps } from "../IconProps.js";

export const UsersIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=User, Name=Users">
      <path
        id="Vector"
        d="M14 13.3339C14 12.1729 12.8869 11.1851 11.3333 10.819M10 13.334C10 11.8612 8.20914 10.6673 6 10.6673C3.79086 10.6673 2 11.8612 2 13.334M10 8.66732C11.4728 8.66732 12.6667 7.47341 12.6667 6.00065C12.6667 4.52789 11.4728 3.33398 10 3.33398M6 8.66732C4.52724 8.66732 3.33333 7.47341 3.33333 6.00065C3.33333 4.52789 4.52724 3.33398 6 3.33398C7.47276 3.33398 8.66667 4.52789 8.66667 6.00065C8.66667 7.47341 7.47276 8.66732 6 8.66732Z"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
