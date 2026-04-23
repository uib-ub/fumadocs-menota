'use client';

import Image from "next/image";
import { useState } from "react";

export default function AutoImage({ src, alt }: { 
    src: string, 
    alt?: string
}) {
    const [dimensions, setDimensions] = useState({ width: 500, height: 500 });
    return (
        <Image
            src={src}
            alt={alt || ''}
            width={dimensions.width}
            height={dimensions.height}
            onLoad={img => {
                setDimensions({
                    width: img.currentTarget.naturalWidth * 100,
                    height: img.currentTarget.naturalHeight * 100
                })
            }}
            className="IMAGE shadow [td_.FIGURE_&]:mt-1 [td_.FIGURE_&]:mb-9 [td>&]:my-1"
            style={{width: 'auto', height: 'auto'}}
        />
    );
}