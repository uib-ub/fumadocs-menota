'use client';

import { getCustomPages } from "@/utils/custom-page";
import { getEuroDate } from "@/utils/date";
import { useParams } from "next/navigation";

export default function NewsItems({ limit }: { limit: number }) {
    const { lang } = useParams<{ lang: string }>();
    const newsPages = getCustomPages({ baseSlugs: ["news"], lang });
    const newest = newsPages
        .filter(page => page.data.date)
        .sort((a, b) => -a.data.date!.toISOString().localeCompare(b.data.date!.toISOString()))
        .slice(0, limit);
    return (
        <ul>
            {newest.map(page => (
                <li key={page.data.date!.toISOString()}>
                    <a href={page.url}>
                        {page.data.title}
                        {" "}
                        ({getEuroDate(page.data.date!)})
                    </a>
                </li>
            ))}
        </ul>
    );
}