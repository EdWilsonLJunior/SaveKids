import type { Meta, StoryObj } from "@storybook/react";
import { Icon, IconSize } from "./Icon.js";
import * as Icons from "./index.js";
import IconsList from "./iconsList.json";

// Helper to format icon names for display
const formatIconName = (name: string) =>
    name
        .replace(/^AI([A-Z])/, "AI $1")
        .replace(/([a-z])([A-Z])/g, "$1 $2")
        .replace("Icon", "")
        .trim();

// Get unique categories
const categories = [
    "All",
    ...Array.from(new Set(IconsList.icons.map((i) => i.category))),
];
const iconSizes: IconSize[] = ["small", "medium", "large", "xlarge"];

const meta: Meta<typeof Icon> = {
    title: "Visual Assets/Icons",
    component: Icon,
    parameters: {
        docs: {
            description: {
                component:
                    'A library of icons with consistent sizing and accessibility support.',
            },
        },
    },
    argTypes: {
        size: {
            control: "select",
            options: iconSizes,
            description: "Icon size preset",
        },
    },
};
export default meta;

type Story = StoryObj<typeof Icon>;

interface PlaygroundArgs {
    category: string;
    size: IconSize;
    iconItem: string;
}

// Group icons by category
const categorizeIcons = () => {
    const result: Record<
        string,
        { name: string; Component: React.ComponentType<any>; recommendedForButtons: boolean }[]
    > = {};

    IconsList.icons.forEach(({ name, category, recommendedForButtons }) => {
        const IconComponent = (Icons as Record<string, React.ComponentType<any>>)[name];
        if (IconComponent) {
            if (!result[category]) result[category] = [];
            result[category].push({ name, Component: IconComponent, recommendedForButtons });
        }
    });

    return result;
};

const iconCategories = categorizeIcons();

// Playground component
const PlaygroundByCategory = ({
    category,
    size,
    iconItem,
}: PlaygroundArgs) => {
    const filteredCategories =
        category === "All" ? Object.keys(iconCategories) : [category];

    const allFilteredIcons = filteredCategories.flatMap((cat) =>
        (iconCategories[cat] || []).filter(
            (icon) => iconItem === "All" || icon.name === iconItem
        )
    );

    if (allFilteredIcons.length === 0) {
        return (
            <div style={{ margin: "48px 0", textAlign: "center", color: "#666" }}>
                <h6 style={{ marginBottom: "16px" }}>No icons available.</h6>
                <p>Check if the "category" control is set to "All".</p>
            </div>
        );
    }

    return (
        <div>
            {filteredCategories.map((cat) => {
                const filteredIcons = (iconCategories[cat] || []).filter(
                    (icon) => iconItem === "All" || icon.name === iconItem
                );
                if (filteredIcons.length === 0) return null;

                return (
                    <div key={cat} style={{ margin: "0 0 64px 0" }}>
                        <h3 style={{ marginBottom: "48px", textAlign: "center" }}>{cat}</h3>
                        <div
                            style={{
                                display: "grid",
                                gridTemplateColumns: "repeat(3, 1fr)",
                                gap: "24px",
                            }}
                        >
                            {filteredIcons.map(({ name, Component }) => (
                                <div
                                    key={name}
                                    style={{
                                        display: "flex",
                                        alignItems: "center",
                                        gap: "24px",
                                        margin: "16px",
                                    }}
                                >
                                    <Icon Component={Component} size={size} />
                                    <div>{formatIconName(name)}</div>
                                </div>
                            ))}
                        </div>
                    </div>
                );
            })}
        </div>
    );
};

// Main Playground story
export const Playground = {
    render: (args: PlaygroundArgs) => <PlaygroundByCategory {...args} />,
    args: {
        category: "All",
        size: "small" as IconSize,
        iconItem: "All",
    },
    argTypes: {
        category: {
            control: "select",
            options: categories,
        },
        size: {
            control: "select",
            options: iconSizes,
        },
        iconItem: {
            control: "select",
            options: ["All", ...IconsList.icons.map((i) => i.name).sort()],
            name: "Select Icon",
        },
    },
};

// Single icon story for documentation
export const SingleIcon: Story = {
    args: {
        Component: Icons.AddPlusIcon,
        size: "medium",
    },
};
