import AutoImage from "./auto-image"

export default function Hero({ children }: { children: React.ReactNode }) {
    return (
        <div className="h-screen w-screen relative overflow-hidden" id="hero">
            <div className="relative z-10 h-9/12 grid grid-cols-1 place-content-between">
                <AutoImage 
                    src='/images/menota-banner-new.svg' 
                    className="m-10 max-w-3/5 min-w-170 p-10 rounded-3xl 
                    bg-white/70 backdrop-blur-xs"
                />
                <div className="
                    m-10 max-w-170 p-10 rounded-3xl
                    backdrop-blur-xs
                    text-white text-xl text-justify">{children}</div>
            </div>
        </div>
    );
}