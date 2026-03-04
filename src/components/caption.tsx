export default function Caption({ title, children }: { 
    title?: string, 
    children: React.ReactNode 
}) {
    return (
        <div className="CAPTION mx-5 -mt-15 -indent-10 pl-10 italic">
            <p className="[&_em]:not-italic">
                <strong className="not-italic">{title}</strong>
                {children}
            </p>
        </div>
    );
}