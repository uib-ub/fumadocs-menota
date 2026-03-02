export default function Caption({ title, children }: { 
    title?: string, 
    children: React.ReactNode 
}) {
    return (
        <div className="-mt-5 italic">
            <p className="[&_em]:not-italic">
                <strong className="not-italic">{title}</strong>
                {children}
            </p>
        </div>
    );
}