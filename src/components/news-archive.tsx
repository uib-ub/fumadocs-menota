import { Accordion, Accordions } from "fumadocs-ui/components/accordion";
import { getCustomPage, getCustomPages } from "@/utils/custom-page";

type PageType = ReturnType<typeof getCustomPage>;

export default function NewsArchive() {
    const lang = "no";
    const news = getCustomPages({ baseSlugs: ["news"], lang });
    const archive: Record<string, PageType[]> = news.reduce((newsByYears: Record<string, PageType[]>, item) => {
        const year = item.data.date?.getFullYear().toString();
        if (year && item.url != '/news') {
            if (!newsByYears[year]) {
                newsByYears[year] = [];
            }
            newsByYears[year].push(item);
        }
        return newsByYears;
    }, {});
    const years: string[] = Object.keys(archive).sort().reverse();
    console.log(years);
    return (
        <Accordions type="single">
            {years.map(year => { return (
                <Accordion key={year} title={year}>
                    <ul>
                        { archive[year]
                            .reverse()
                            .map(item => { return (
                                <li>
                                    <a href={item?.url}>{item?.data.title}</a>
                                </li>
                            )})
                        }
                    </ul>
                </Accordion>
            )})}
        </Accordions>
    );
}