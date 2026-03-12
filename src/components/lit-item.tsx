import { BookText } from "lucide-react";

export default function LitItem({ id, children }: { id: string, children: React.ReactNode }) {
    return (
        <div id={id} className="flex">
            <BookText className="mt-5 w-20 h-7 flex-none"/>
            <div className="-indent-10 pl-10">
                {children}
            </div>
        </div>
    );
}