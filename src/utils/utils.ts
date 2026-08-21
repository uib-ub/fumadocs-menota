import { source } from "@/lib/source";
import type { CustomPage } from "@/types/changes";

export function getCustomPage({slug, lang, basePath: baseURL}: { 
  slug: string[] | undefined, 
  lang: string, 
  basePath?: string 
}) {
  const page = baseURL 
    ? source.getPage([baseURL, ...slug || []], lang) 
    : source.getPage([...slug || []], lang);
  if (page) return page as CustomPage;
}