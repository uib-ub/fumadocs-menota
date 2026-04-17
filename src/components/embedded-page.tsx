'use client';

import { useEffect, useRef } from "react";

export default function EmbeddedPage({ src, name }: { src: string, name?: string }) {
    const iframeRef = useRef<HTMLIFrameElement>(null);
    useEffect(() => {
        const iframe = iframeRef.current;
        if (!iframe) return;

        const handler = () => {
            const doc = iframe.contentDocument;
            if (!doc) return;

            const links = doc.querySelectorAll("a");
            links.forEach(link => {
                link.addEventListener("click", e => {
                    if (link.href.startsWith("#")) return;
                    if (link.target == "_blank") return;
                    e.preventDefault();
                    window.top!.location.href = link.href;
                })
            });
        }

        iframe.addEventListener("load", handler);

        return () => {
            iframe.removeEventListener("load", handler);
        };
    });

    return (
        <iframe
            ref={iframeRef}
            name={name}
            src={src}
            width="100%"
            height="100%"
            className="dark:invert"
        />
    );
}