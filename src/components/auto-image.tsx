'use client';

import Image from "next/image";
import { useState } from "react";

export default function AutoImage({ src, alt }: { src: string, alt?: string}) {
    const [dimensions, setDimensions] = useState({ width: 0, height: 0 });
    return (
        <Image
            src={src}
            alt={alt || ''}
            width={dimensions.width}
            height={dimensions.height}
            onLoadingComplete={img => {
                setDimensions({
                    width: img.naturalWidth * 100,
                    height: img.naturalHeight * 100
                })
            }}
            style={{width: 'auto', height: 'auto'}}
        />
    );
}