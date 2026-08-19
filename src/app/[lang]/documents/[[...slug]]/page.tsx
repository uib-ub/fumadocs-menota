import { getPageImage, source } from '@/lib/source';
import Image from 'next/image';
import { DocsBody, DocsPage } from 'fumadocs-ui/layouts/docs/page';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import { getCustomPage } from '@/utils/utils';
import Footer from '@/components/footer';

export default async function Page(props: PageProps<'/[lang]/documents/[[...slug]]'>) {
  const { lang, slug } = await props.params;
  //const page = source.getPage(["documents", ...slug || []], lang);
  const page = getCustomPage({ slug, lang, basePath: "documents" })
  if (!page) notFound();
  const { contentGroup, contentStyle }: { 
    contentGroup: 'html' | 'main',
    contentStyle: 'old' | 'menota-main'
  } = (() => {
    const route = slug?.join("/") || '';
    if (route == "statutes/draft"
      || route.match(/^council\/members\/200[24]-200[36]$/)
      || route.match(/^depo\//)
      || route.match(/^editorial-board\//))
      return { contentGroup: 'html', contentStyle: 'old'};
    return { contentGroup: 'main', contentStyle: 'menota-main' };
  })();

  const MDX = page.data.body;

  return (
    <DocsPage 
      toc={contentStyle == "old" ? undefined : page.data.toc} 
      breadcrumb={{enabled: false}}
      full={page.data.full} 
      className={`docspage ${contentStyle}`}
    >
      {(() => {switch (contentGroup) {
        case "html":
          return;
        default:
          return (
            <div className='flex flex-wrap mb-5 dark:invert'>
              <Image src='/images/Menota-banner-new.svg' alt='Menota banner' width={900} height={100}/>
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
      { contentGroup == "html" ? null : <Footer log={page.data.changeLog} lang={lang}/> }
    </DocsPage>
  );
}

export async function generateStaticParams() {
  return source.generateParams();
}

export async function generateMetadata(props: PageProps<'/[lang]/documents/[[...slug]]'>): Promise<Metadata> {
  const { slug, lang } = await props.params;
  const page = source.getPage(["documents", ...slug || []], lang);
  if (!page) notFound();

  return {
    title: page.data.title,
    description: page.data.description,
    openGraph: {
      images: getPageImage(page).url,
    },
  };
}
