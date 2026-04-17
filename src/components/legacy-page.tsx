'use client';

import EmbeddedPage from "@/components/embedded-page";

export default function LegacyPage({ slug }: { slug: string[] }) {
    const notFound = <div>Page not found.</div>;
    if (slug.length < 2) return notFound;
    const pageName = slug[2] || 'contents';
    const version = pageName == 'dtd' && slug[1] == "v1-1" ? 
        '1-1-1' :
        slug[1].substring(1);
    switch(version) {
        case "1-0":
        case "1-1":
        case "1-1-1":
            const source = pageName == 'literature' ? 
                `/legacy/handbook/v1/HB1_${pageName}.html` :
                `/legacy/handbook/v1/HB${version}_${pageName}.html`;
            return <EmbeddedPage src={source} name={pageName}/>;
    }
    return <p>{slug.join(" | ")}</p>;
}