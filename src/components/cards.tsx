export function Cards({ children }: { children: React.ReactNode }) {
    return (<div className="mt-5 grid grid-cols-2 gap-3">{children}</div>);
}

export function Card({ title, href, children }: { 
    title: string, 
    href?: string, 
    children: React.ReactNode 
}) {
    return (
        <a href={href || undefined}className="
            card 
            rounded-xl border p-4
            bg-fd-card/80 text-fd-card-foregroundblock transition-colors 
            text-slate-700
            @max-lg:col-span-full hover:bg-green-200/20
        ">
            <h3 className="mb-1 text-lg font-medium ">{title}</h3>
            <div>{children}</div>
        </a>
    );
}