'use client';

import Image from "next/image";
import { useState } from "react";

export default function AutoImage({ src, alt, width, height, className }: { 
    src: string, 
    alt?: string,
    width?: number,
    height?: number,
    className?: string
}) {
    const [dimensions, setDimensions] = useState({ setWidth: 500, setHeight: 500 });
    return (
        <Image
            src={src}
            alt={alt || ''}
            width={dimensions.setWidth}
            height={dimensions.setHeight}
            onLoad={img => {
                setDimensions({
                    setWidth: width ?? img.currentTarget.naturalWidth * 100,
                    setHeight: height ?? img.currentTarget.naturalHeight * 100
                })
            }}
            className={`IMAGE shadow [td_.FIGURE_&]:mt-1 [td_.FIGURE_&]:mb-9 [td>&]:my-1 ${className}`}
            style={{width: 'auto', height: 'auto'}}
        />
    );
}