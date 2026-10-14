import { source } from '@/lib/source';
import { DocsLayout } from 'fumadocs-ui/layouts/notebook';
import { baseOptions } from '@/lib/layout.shared';

export default async function Layout({ params, children }: LayoutProps<'/[lang]/other'>) {
  const { lang } = await params;
  const { nav, ...base } = baseOptions(lang as "en" | "no");
  return (
    <DocsLayout 
      {...base}
      nav={{ ...nav, mode: "top" }}
      tree={source.getPageTree(lang)} 
    >
      {children}
    </DocsLayout>
  );
}
