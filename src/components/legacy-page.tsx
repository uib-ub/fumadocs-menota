'use client';

import EmbeddedPage from "@/components/embedded-page";

export default function LegacyPage({ slug }: { slug: string[] }) {
    const notFound = <div>Page not found.</div>;
    switch (slug[0]) {
        case "handbook": {
            if (slug.length < 2) return notFound;
            const pageName = slug[2] || 'contents';
            const version = (() => {
                switch (pageName) {
                    case "dtd":
                        if (slug[1] == "v1-1") return '1-1-1';
                        break;
                    case "literature":
                        if (slug[1] == "v1-0") return '1';
                        break;
                }
                return slug[1].substring(1);
            })();
            const source = `/legacy/handbook/v1/HB${version}_${pageName}.html`;
            return <EmbeddedPage src={source} name={pageName}/>;
        }
        case "documents": {
            if (slug.join("/") == "documents/statutes/draft")
                return <EmbeddedPage src={'/legacy/documents/DOK_vedtekter-utkast.html'}/>;
        }
    }
}