import Caption from "@/components/caption";

export default function Figure({ caption, children }: { 
    caption?: string,
    children: React.ReactNode 
}) {

    return (
        <div className="ml-5 mb-10">
            <div className="flex [&>.CAPTION]:hidden">
                {children}
            </div>
            <div className="[&>.CAPTION]:-mt-10 [&>.CAPTION]:ml-0 [&>.IMAGE]:hidden">
                {children}
            </div>
            {caption ? <Caption>{caption}</Caption> : null}
        </div>
    );
}