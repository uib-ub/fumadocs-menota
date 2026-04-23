export default function HI({ color, style, children }: {
    color?: 'blue' | 'red',
    style?: 'bold' | 'initial',
    children: React.ReactNode }
) {
    return (
        <span className={`highlight
            ${color == 'blue' ? `text-blue-500` : ''}
            ${color == 'red' ? `text-red-500` : ''}
            ${style == 'bold' ? 'font-bold' : ''}
            ${style == 'initial' ? 'font-bold text-2xl' : ''}
        `}>
            {children}
        </span>
    );
}