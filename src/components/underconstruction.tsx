import { Drill, Wrench } from "lucide-react";

export default function UnderConstruction({ children }: { children: React.ReactNode }) {
    return (
        <div className={`
            mt-20 
            border-8 
            border-dashed
            rounded-3xl 
            p-10 
            flex 
            flex-col md:flex-row
            justify-center
        `}>
            <div className="place-self-center">
                <Drill className="h-20 w-20"/>
            </div>
            <div className={`
                mt-10 md:mt-0 
                mx-2 md:mx-10 
                content-center 
                text-3xl 
                text-center
            `}>
                {children ? <p>{children}</p> : null}
                <span className="font-mono">UNDER CONSTRUCTION</span>
            </div>
            <div className="hidden md:block place-self-center">
                <Wrench className="h-20 w-20 transform -scale-x-100"/>
            </div>
        </div>
    );
}