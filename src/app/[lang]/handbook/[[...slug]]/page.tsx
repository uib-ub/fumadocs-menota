import { getPageImage, source } from '@/lib/source';
import Image from 'next/image';
import { DocsBody, DocsPage } from 'fumadocs-ui/layouts/notebook/page';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import { getCustomPage } from '@/utils/utils';
import Footer from '@/components/footer';

export default async function Page(props: PageProps<'/[lang]/handbook/[[...slug]]'>) {
  const { lang, slug } = await props.params;
  const page = getCustomPage({ slug, lang, basePath: "handbook" })
  if (!page) notFound();
  const { contentGroup, contentStyle }: { 
    contentGroup: 'html' | 'hb2' | 'hb3' | 'hb4' | 'main',
    contentStyle: 'hb-new' | 'old' | 'menota-main'
  } = (slug => {
    if (slug) {
      switch (slug[0]) {
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

export async function generateMetadata(props: PageProps<'/[lang]/handbook/[[...slug]]'>): Promise<Metadata> {
  const { slug, lang } = await props.params;
  const page = source.getPage(["handbook", ...slug || []], lang);
  if (!page) notFound();

  return {
    title: page.data.title,
    description: page.data.description,
    openGraph: {
      images: getPageImage(page).url,
    },
  };
}
