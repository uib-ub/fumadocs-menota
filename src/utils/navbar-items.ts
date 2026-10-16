import { LinkItemType } from "fumadocs-ui/layouts/shared";

export function navbarItems(lang: "en" | "no"): LinkItemType[] {
    return items.map(item => {
        return {
            ...item,
            text: item.text?.[lang] ?? "?"
        }
    }) as LinkItemType[];
}

const items = [
    {
        text: {
            "no": "Tekstarkiv",
            "en": "Text Archives"
        },
        url: 'https://clarino.uib.no/menota/catalogue/menota'
    },
    {
        text: {
            en: "News",
            no: "Nyheter"
        },
        url: '/news'
    },
    {
        text: {
            "no": "Håndbok",
            "en": "Handbook"
        },
        url: '/handbook',
    },
    {
        text: {
            "no": "Dokumenter",
            "en": "Documents"
        },
        url: '/documents'
    },
    {
        text: {
            "no": "Andre ressurser",
            "en": "Other resources"
        },
        url: '/other'
    }
]