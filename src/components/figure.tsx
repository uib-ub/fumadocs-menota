import Caption from "@/components/caption";

export default function Figure({ desc, caption, children }: { 
    desc?: string, // Image description, usually designating copyright
    caption?: string,
    children: React.ReactNode 
}) {
    return (
        <div className="FIGURE mx-5 mb-15">
            <div className="flex flex-wrap [&_.CAPTION]:hidden">
                {children}
            </div>
            <div className={`-mt-8 [&_.CAPTION]:mx-0 [&_.CAPTION]:-mt-4 [&_.IMAGE]:hidden`}>
                {desc ? <span className={`text-xs font-[Verdana]`}>{desc}</span> : null}
                {caption ? <Caption>{caption}</Caption> : null}
                {children}
            </div>
        </div>
    );
}