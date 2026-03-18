export default function HI({ color, style, children }: {
    color?: 'blue' | 'red',
    style?: 'bold',
    children: React.ReactNode }
) {
    return (
        <span className={`highlight
            ${color && color == 'blue' ? `text-blue-500` : ''}
            ${color && color == 'red' ? `text-red-500` : ''}
            ${style == 'bold' ? 'font-bold' : ''}
        `}>
            {children}
        </span>
    );
}