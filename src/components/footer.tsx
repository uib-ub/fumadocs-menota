import type { Change } from "@/types/changes";
import UiBLogo from "@/components/uib-logo";
import KULogo from "@/components/ku-logo";

export default function Footer({ log, lang, className }: { 
    log: Change[], 
    lang: string,
    className?: string
}) {
    log?.sort((a, b) => a.date.toISOString().localeCompare(b.date.toISOString()));
    const first = log?.[0];
    const last = log?.length > 1 ? log?.[log.length - 1] : undefined;
    return (
        <div className={`w-full border-t-2 mt-5 p-3 text-sm text-center ${className}`}>
            <div className="flex flex-row justify-center *:mb-5 *:mx-5">
                <UiBLogo className="w-100 fill-black dark:fill-white"/>
                <KULogo className="w-70"/>
            </div>
            <div className="pb-2">
                { lang == "no" ? 
                    `Opprettet ${getEuroDate(first?.date) || '?'}. ` : 
                    `Created ${getISODate(first?.date) || '?'}. ` }
                { last ? (lang == "no" ? 
                    `Sist oppdatert ${getEuroDate(last.date)}.` : 
                    `Last changed ${getISODate(last.date)}`) : ''}
            </div>
            <div>{ lang == "no" ? "Tilgjengelighetserklæring" : "Accessibility declaration"}</div>
        </div>
    );
}

function getEuroDate(date: Date | undefined): string | undefined {
    if (!date) return;
    const day = date.getDate().toString().padStart(2, "0");
    const month = (date.getMonth() + 1).toString().padStart(2, "0");
    const year = date.getFullYear();
    return `${day}.${month}.${year}`;
}

function getISODate(date: Date | undefined): string | undefined {
    if (!date) return;
    return date.toISOString().substring(0, 10);
}