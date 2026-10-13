import { LinkItemType } from "fumadocs-ui/utils/link-item"

export function navbarItems(lang: "en" | "no"): LinkItemType[] {
    return items.map(item => {
        if (item.type == 'menu') {
            return {
                ...item, 
                text: item.text?.[lang] ?? "?",
                items: item.items.map(subitem => ({
                    ...subitem,
                    text: subitem.text?.[lang] ?? "?"
                }))
            }
        }
        return {
            ...item,
            text: item.text?.[lang] ?? "?"
        }
    }) as LinkItemType[];
}

const items = [
    {
        type: 'menu',
        text: {
            "no": "Tekstarkiv",
            "en": "Text Archives"
        },
        items: [
            {
                text: {
                    "no": "Hovedarkiv",
                    "en": "Main Archive"
                },
                url: 'https://clarino.uib.no/menota/catalogue/menota'
            },
            {
                text: {
                    "no": "Andre arkiv",
                    "en": "Other archives"
                },
                url: '/other/archives'
            }
        ]
    },
    {
        text: {
            en: "News",
            no: "Nyheter"
        },
        url: '/news'
    },
    {
        type: 'menu',
        text: {
            "no": "Håndbok",
            "en": "Handbook"
        },
        url: '/handbook',
        items: [
        {
            text: {
                "no": "Håndbok 3",
                "en": "Handbook 3"
            },
            url: '/handbook/v3'
        },
        {
            text: {
                "no": "Håndbok 2",
                "en": "Handbook 2"
            },
            url: '/handbook/v2'
        },
        {
            text: {
                "no": "Håndbok 1.1",
                "en": "Handbook 1.1"
            },
            url: '/handbook/v1-1'
        },
        {
            text: {
                "no": "Håndbok 1.0",
                "en": "Handbook 1.0"
            },
            url: '/handbook/v1-0'
        }
        ]
    },
    {
        type: 'menu',
        text: {
            "no": "Dokumenter",
            "en": "Documents"
        },
        items: [
            {
                text: {
                    "no": "Styre",
                    "en": "Board"
                },
                url: '/documents/board'
            },
            {
                text: {
                    "no": "Råd",
                    "en": "Council"
                },
                url: '/documents/council'
            },
            {
                text: {
                    "no": "Redaksjon",
                    "en": "Editorial Board"
                },
                url: '/documents/editorial-board'
            },
            {
                text: {
                    "no": "Vedtekter",
                    "en": "Statutes"
                },
                url: '/documents/statutes'
            },
            {
                text: {
                    "no": "Deponeringsavtale",
                    "en": "Deposition Agreement"
                },
                url: '/documents/depo'
            },
            {
                text: {
                    "no": "Stiftelse",
                    "en": "Foundation"
                },
                url: '/documents/council/meetings/2001-09-10'
            }
        ]
    },
    {
        type: 'menu',
        text: {
            "no": "Annet",
            "en": "Other"
        },
        items: [
            {
                text: {
                    "no": "Andre arkiver",
                    "en": "Other archives"
                },
                url: '/other/archives'
            },
            {
                text: {
                    "no": "Ordboksressurser",
                    "en": "Lexicographic resources"
                },
                url: '/other/dictionaries'
            }
        ]
    }
]