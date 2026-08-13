import Image from "next/image";

export default function Tile({ title, image, children }: { 
    title: string, 
    image?: string,
    children: React.ReactNode 
}) {
    return (
        <div className="m-10 w-3/5 min-w-170 rounded-3xl p-10 bg-white/60 backdrop-blur-xs">
            <h2 id={title} className="mb-5 text-3xl font-bold text-green-800">{title}</h2>
            <div className="flex flex-row">
                {image ? <TileImage src={image}/> : null}
                <div className="mr-5 text-sm text-justify">{children}</div>
            </div>
        </div>
    );
}

function TileImage({ src }: { src: string }) {
    return (
        <div className="min-w-40">
            <img src={src} height={120} width={120}/>
        </div>
    );
}