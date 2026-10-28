'use client';

import { getCustomPages } from "@/utils/custom-page";
import { useParams } from "next/navigation";

export default function NewsItems({ limit }: { limit: number }) {
    const { lang } = useParams<{ lang: string }>();
    const newsPages = getCustomPages({ baseSlugs: ["news"], lang });
    const newest = newsPages
        .filter(page => page.data.date)
        .filter(page => !page.url.endsWith("/news"))
        .sort((a, b) => -a.data.date!.toISOString().localeCompare(b.data.date!.toISOString()))
        .slice(0, limit);
    return (
        <ul>
            {newest
                .map(page => (
                <li key={page.data.date!.toISOString()}>
                    <a href={page.url}>
                        {page.data.title}
                    </a>
                </li>
            ))}
        </ul>
    );
}