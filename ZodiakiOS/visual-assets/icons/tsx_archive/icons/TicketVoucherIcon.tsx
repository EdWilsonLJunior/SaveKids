import { IconProps } from "../IconProps.js";

export const TicketVoucherIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Interface, Name=Ticket_Voucher">
      <path
        id="Vector"
        d="M9.33333 4H4C3.37874 4 3.06794 4 2.82292 4.10149C2.49621 4.23682 2.23682 4.49654 2.10149 4.82324C2 5.06827 2 5.3789 2 6.00015C3.10457 6.00015 4 6.89528 4 7.99985C4 9.10442 3.10457 10 2 10C2 10.6213 2 10.9319 2.10149 11.1769C2.23682 11.5036 2.49621 11.7631 2.82292 11.8984C3.06794 11.9999 3.37875 12 4 12H9.33333M9.33333 4H12C12.6213 4 12.9319 4 13.1769 4.10149C13.5036 4.23682 13.7631 4.49654 13.8984 4.82324C13.9999 5.06827 13.9999 5.3789 13.9999 6.00015C12.8954 6.00015 12 6.89543 12 8C12 9.10457 12.8954 10 13.9999 10C13.9999 10.6213 13.9999 10.9319 13.8984 11.1769C13.7631 11.5036 13.5036 11.7631 13.1769 11.8984C12.9319 11.9999 12.6213 12 12 12H9.33333M9.33333 4V12"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
