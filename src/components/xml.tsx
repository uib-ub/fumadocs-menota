import { codeToHtml } from "shiki";
import { 
    transformerCompactLineOptions, 
    transformerRemoveLineBreak 
} from "@shikijs/transformers";

const inlineTransformer = {
    line(node: any) {
        if (node.properties?.className?.includes('line')) {
            node.children = node.children.flat();
            delete node.properties?.className;
        }
    },
    root(node: any) {
        node.tagName = 'span';
        delete node.properties;
    }
}

export async function E({ children }: { children: string }) {
    const html = (await codeToHtml(`<${children}>`, {
        lang: 'xml', 
        theme: 'github-light',
        transformers: [
            transformerCompactLineOptions(),
            transformerRemoveLineBreak(),
            inlineTransformer
        ]
    })).replace(/ class="line"/, ''); // Yikes, dirty hack!
    console.log(html);
    return <span className="inline-flex" dangerouslySetInnerHTML={{ __html: html }}/>
}