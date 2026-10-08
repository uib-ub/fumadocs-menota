import { getPageImage, source } from '@/lib/source';
import { DocsBody, DocsPage } from 'fumadocs-ui/layouts/notebook/page';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import { getCustomPage } from '@/utils/custom-page';
import Footer from '@/components/footer';
import AutoImage from '@/components/auto-image';

export default async function Page(props: PageProps<'/[lang]/other/[[...slug]]'>) {
  const { lang, slug } = await props.params;
  const page = getCustomPage({ slug, lang, basePath: "other" })
  if (!page) notFound();
  const { contentGroup, contentStyle }: { 
    contentGroup: 'html' | 'hb2' | 'hb3' | 'hb4' | 'main',
    contentStyle: 'hb-new' | 'old' | 'menota-main'
  } = (slug => {
    const route = slug?.join("/") || '';
    if (route == "documents/statutes/draft"
      || route.match(/^documents\/council\/members\/200[24]-200[36]$/)
      || route.match(/^documents\/depo\//)
      || route.match(/^documents\/editorial-board\//))
      return { contentGroup: 'html', contentStyle: 'old'};
    return { contentGroup: 'main', contentStyle: 'menota-main' };
  })(slug);

  const MDX = page.data.body;

  return (
    <DocsPage 
      toc={contentStyle == "old" ? undefined : page.data.toc} 
      breadcrumb={{enabled: false}}
      full={page.data.full} 
      footer={{items: {}}}
      //slots={{ footer: contentGroup == "html" ? null : <Footer context="other"/> }}
      className={`docspage ${contentStyle}`}
    >
      {(() => {switch (contentGroup) {
        case "html":
          return;
        default:
          return (
            <div className='flex flex-wrap mb-5 dark:invert'>
              <AutoImage src='/images/Menota-banner-new.svg' className="
                border
                p-1 rounded-lg
                sm:p-3 sm:rounded-xl
                md:p-10 md:rounded-3xl 
                bg-white/80 backdrop-blur-xs
              "/>
            </div>
          );
      }})()}
      <DocsBody>
        <MDX
          components={getMDXComponents({
            // this allows you to link to other pages with relative file paths
            a: createRelativeLink(source, page),
          })}
        />
      </DocsBody>
      <Footer context="other"/>
    </DocsPage>
  );
}

export async function generateStaticParams() {
  return source.generateParams();
}

export async function generateMetadata(props: PageProps<'/[lang]/other/[[...slug]]'>): Promise<Metadata> {
  const { slug, lang } = await props.params;
  const page = source.getPage(["other", ...slug || []], lang);
  if (!page) notFound();

  return {
    title: page.data.title,
    description: page.data.description,
    openGraph: {
      images: getPageImage(page).url,
    },
  };
}
