import Image from "next/image";

export default function InlineImage({src, alt}: {src: string, alt?: string}) {
    return (
        <Image 
            src={src} 
            alt={alt || ''} 
            height={109} 
            width={100} 
            className="float-left mt-1 mr-5 mb-2"
        />
    )
}