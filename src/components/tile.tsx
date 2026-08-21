import Image from "next/image";

export default function Tile({ title, image, children }: { 
    title: string, 
    image?: string,
    children: React.ReactNode 
}) {
    return (
        <div className="
            mx-1 my-5 rounded-lg p-3
            sm:m-5 sm:rounded-xl sm:p-5
            md:m-10 md:w-3/5 md:min-w-170 md:rounded-3xl md:p-10 
            bg-white/60 dark:bg-slate-950/70 backdrop-blur-xs
        ">
            <h2 id={title} className="
                mb-3 text-xl
                sm:mb-5 sm:text-3xl 
            ">{title}</h2>
            <div className="flex flex-row">
                {image ? <TileImage src={image}/> : null}
                <div className="
                    sm:mr-5 
                    text-sm text-justify
                ">{children}</div>
            </div>
        </div>
    );
}

function TileImage({ src }: { src: string }) {
    return (
        <div className="hidden sm:block min-w-40">
            <img src={src} height={120} width={120}/>
        </div>
    );
}