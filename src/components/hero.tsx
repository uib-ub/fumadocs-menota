import AutoImage from "./auto-image"

export default function Hero({ children }: { children: React.ReactNode }) {
    return (
        <div className="h-screen w-screen relative overflow-hidden">
            <div className="absolute inset-0 bg-[url('/images/nordr.jpeg')] bg-cover bg-right"/>
            <div className="absolute inset-0 bg-linear-to-r from-slate-950/80 to-slate-950/0"/>
            <div className="relative z-10 h-9/12 grid grid-cols-1 place-content-between">
                <AutoImage src='/images/menota-banner-new.svg' className="m-10 max-w-2/5 bg-white/60"/>
                <div className="m-10 max-w-1/3 text-white text-xl">{children}</div>
            </div>
        </div>
    );
}