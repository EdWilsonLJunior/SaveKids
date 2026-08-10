import { IconProps } from "../IconProps.js";

export const PaperclipAttachmentTiltIcon = ({
  width = "16px",
 height = "16px",
  color = "currentColor", strokeWidth = 1, className,
  ...props
}: IconProps) => (
  <svg viewBox="0 0 16 16" width={width} height={height} fill="none" {...props}>
    <g id="Category=Edit, Name=Paperclip_Attechment_Tilt">
      <path
        id="Vector"
        d="M3.02344 7.6428L7.61963 3.04661C8.98647 1.67978 11.2026 1.67978 12.5694 3.04661C13.9363 4.41345 13.9361 6.62965 12.5693 7.99648L7.26595 13.2998C6.35473 14.211 4.87759 14.2109 3.96637 13.2997C3.05515 12.3884 3.05492 10.9112 3.96615 9.99998L9.26945 4.69668C9.72506 4.24106 10.4641 4.24106 10.9198 4.69668C11.3754 5.15229 11.375 5.8908 10.9194 6.34642L6.32324 10.9426"
        stroke={color} strokeLinecap="round"
        strokeLinejoin="round"
      />
    </g>
  </svg>
);
