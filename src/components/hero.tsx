import AutoImage from "./auto-image"

export default function Hero({ children }: { children: React.ReactNode }) {
    return (
        <div className="md:h-screen md:w-screen md:relative md:overflow-hidden" id="hero">
            <div className="md:relative z-10 h-9/12 grid grid-cols-1 place-content-around">
                <AutoImage src='/images/Menota-banner-new.svg' className="
                    my-5 m-1 p-2 rounded-lg
                    sm:m-5 sm:p-3 sm:rounded-xl
                    md:m-10 md:max-w-3/5 md:min-w-170 md:p-10 md:rounded-3xl 
                    bg-white/70 backdrop-blur-xs
                "/>
                <h1 className="hidden">Medieval Nordic Text Archive</h1>
                <div className="
                    m-1 mb-5 p-3 rounded-lg text-sm bg-black/30 
                    sm:m-5 sm:rounded-xl sm:text-base 
                    md:m-10 md:max-w-170 md:p-10 md:rounded-3xl md:text-lg/relaxed md:bg-black/0
                    [@media(max-height:750px)]:max-w-250
                    backdrop-blur-xs
                    text-white text-justify
                ">{children}</div>
            </div>
        </div>
    );
}