import { codeToHtml } from "shiki";
import { 
    transformerCompactLineOptions, 
    transformerRemoveLineBreak 
} from "@shikijs/transformers";

export async function E({ children }: { children: string }) {
    return <span 
        suppressHydrationWarning 
        className="xml-tag inline-flex" 
        dangerouslySetInnerHTML={{ __html: await parse(`<${children}>`, "xml") }}/>;
}

export async function Att({ children }: { children: string }) {
    return <span
        suppressHydrationWarning
        className="xml-attribute inline-flex"
        dangerouslySetInnerHTML={{ __html: await parse(`@${children}`, "sh") }}/>
}

export async function Val({ children }: { children: string }) {
    return <span
        suppressHydrationWarning
        className="xml-attvalue inline-flex"
        dangerouslySetInnerHTML={{ __html: await parse(`"${children}"`, "js") }}/>
}

async function parse(input: string, lang: 'xml' | 'js' | 'sh') {
    return (await codeToHtml(input, {
        lang, 
        themes: {
            light: 'github-light',
            dark: 'github-dark'
        },
        transformers: [
            transformerCompactLineOptions(),
            transformerRemoveLineBreak()
        ]
    })).replace(/<span class="line">/, '<span>'); // Yikes, dirty hack!
} 