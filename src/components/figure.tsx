import Caption from "@/components/caption";

export default function Figure({ caption, children }: { 
    caption?: string,
    children: React.ReactNode 
}) {
    return (
        <div className="mb-10">
            <div className="flex">
                {children}
            </div>
            {caption ? <Caption>{caption}</Caption> : null}
        </div>
    );
}