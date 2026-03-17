export default function HI({ color, style, children }: {
    color?: 'blue' | 'red',
    style?: 'bold',
    children: React.ReactNode }
) {
    return (
        <span className={`highlight
            ${color ? `text-${color}-500` : ''}
            ${style == 'bold' ? 'font-bold' : ''}
        `}>
            {children}
        </span>
    );
}