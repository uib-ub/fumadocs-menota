import { getPageImage, source } from '@/lib/source';
import Image from 'next/image';
import { DocsBody, DocsPage } from 'fumadocs-ui/layouts/notebook/page';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';

export default async function Page(props: PageProps<'/[lang]/other/[[...slug]]'>) {
  const { lang, slug } = await props.params;
  const page = source.getPage(["other", ...slug || []], lang);
  if (!page) notFound();
  const { contentGroup, contentStyle }: { 
    contentGroup: 'html' | 'hb2' | 'hb3' | 'hb4' | 'main',
    contentStyle: 'hb-new' | 'old' | 'menota-main'
  } = (slug => {
    const route = slug?.join("/") || '';
    if (slug && slug[0] == "handbook") {
      switch (slug[1]) {
        case "v1-0":
        case "v1-1":
          return { contentGroup: "html", contentStyle: "old" }
        case "v2":
          return { contentGroup: "hb2", contentStyle: "hb-new" };
        case "v3":
          return { contentGroup: "hb3", contentStyle: "hb-new" };
        case "v4":
          return { contentGroup: "hb4", contentStyle: "hb-new" };
        default:
          return { contentGroup: "main", contentStyle: "menota-main" };
      }
    }
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
      className={`docspage ${contentStyle}`}
    >
      {(() => {switch (contentGroup) {
        case "html":
          return;
        case "hb2":
          return (
            <div className='dark:invert'>
              <Image src='/images/hb2/handbook_2-0.gif' alt='Menota handbook 2.0' width={600} height={65}/>
              <hr className='my-5 border-2 dark:border-gray-500'/>
            </div>
          );
        case "hb3":
        case "hb4":
          return (
            <div className='mb-5 border-b border-solid border-black pb-3'>
              <div style={{fontSize: '1.8em', fontWeight: '600', color: 'rgb(24, 41, 131)'}}>
                Menota Handbook {contentGroup == "hb3" ? "3.0" : "4.0 β"}
              </div>
              <div style={{fontSize: '1.1em', fontWeight: '400', color: 'rgb(16, 93, 71)'}}>
                Guidelines for the electronic encoding of<br/>
                Medieval Nordic primary sources
              </div>
            </div>
          );
        default:
          return (
            <div className='flex flex-wrap mb-5 dark:invert'>
              <Image src='/images/Menota-banner.gif' alt='Menota banner' width={300} height={65}/>
              <Image src='/images/Menota-banner-3.gif' alt='Menota banner' width={304} height={64}/>
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
