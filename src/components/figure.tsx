export default function Figure({ caption, children }: { 
    caption?: string,
    children: React.ReactNode 
}) {
    return (
        <div className="mb-10">
            <div className="flex">
                {children}
            </div>
            <div className="-mt-5 text-xs italic">{caption}</div>
        </div>
    );
}