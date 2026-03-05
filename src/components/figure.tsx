import Caption from "@/components/caption";

export default function Figure({ desc, caption, children }: { 
    desc?: string,
    caption?: string,
    children: React.ReactNode 
}) {

    return (
        <div className="FIGURE mx-5 mb-15">
            <div className="flex [&_.CAPTION]:hidden">
                {children}
            </div>
            <div className={`-mt-8 [&_.CAPTION]:mx-0 [&_.IMAGE]:hidden [&_.CAPTION]:-mt-4`}>
                {desc ? <span className={`text-xs font-[Verdana]`}>{desc}</span> : null}
                {caption ? <Caption>{caption}</Caption> : null}
                {children}
            </div>
        </div>
    );
}