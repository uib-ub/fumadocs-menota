export default function Caption({ title, children }: { 
    title?: string, 
    children: React.ReactNode 
}) {
    return (
        <div className={`CAPTION mx-5 -mt-15 mb-15 italic ${title ? "-indent-10 pl-10" : ""}`}>
            <p className="[&_em]:not-italic text-sm">
                <strong className="not-italic">{title}</strong>
                {children}
            </p>
        </div>
    );
}