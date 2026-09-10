import { source } from "@/lib/source";
import type { CustomPage } from "@/types/custom";

export function getCustomPage({slug, lang, basePath: baseURL}: { 
  slug?: string[],
  lang: string, 
  basePath?: string 
}) {
  const page = baseURL 
    ? source.getPage([baseURL, ...slug || []], lang) 
    : source.getPage([...slug || []], lang);
  if (page) return page as CustomPage;
}

export function getCustomPages({ baseSlugs, lang }: {
  baseSlugs?: string[],
  lang: string
}) {
  let pages = source.getPages(lang) as CustomPage[];
  for (let i = 0; i < (baseSlugs?.length || 0); i++) {
    pages = pages.filter(page => page.slugs[i] == baseSlugs![i]);
  }
  return pages;
}