'use client';

import EmbeddedPage from "@/components/embedded-page";

export default function LegacyPage({ slug }: { slug: string[] }) {
    const notFound = <div>Page not found.</div>;
    if (slug.length < 2) return notFound;
    const pageName = slug[2] || 'contents';
    switch(slug[1]) {
        case "v1-0": {
            const source = `/legacy/handbook/v1/HB1-0_${pageName}.html`;
            return <EmbeddedPage src={source} name={pageName}/>;
        }
    }
    return <p>{slug.join(" | ")}</p>;
}