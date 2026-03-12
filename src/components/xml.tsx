import { codeToHtml } from "shiki";
import { 
    transformerCompactLineOptions, 
    transformerRemoveLineBreak 
} from "@shikijs/transformers";

export async function E({ children }: { children: string }) {
    const html = (await codeToHtml(`<${children}>`, {
        lang: 'xml', 
        theme: 'github-light',
        transformers: [
            transformerCompactLineOptions(),
            transformerRemoveLineBreak()
        ]
    })).replace(/<span class="line">/, '<span>'); // Yikes, dirty hack!
    console.log(html);
    return <span 
        suppressHydrationWarning 
        className="xml-tag inline-flex" 
        dangerouslySetInnerHTML={{ __html: html }}/>
}