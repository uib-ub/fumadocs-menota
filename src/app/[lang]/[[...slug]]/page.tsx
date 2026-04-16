import { getPageImage, source } from '@/lib/source';
import Image from 'next/image';
import { DocsBody, DocsDescription, DocsPage, DocsTitle } from 'fumadocs-ui/layouts/docs/page';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import LegacyPage from '@/components/legacy-page';

export default async function Page(props: PageProps<'/[lang]/[[...slug]]'>) {
  const { lang, slug } = await props.params;
  const page = source.getPage(slug, lang);
  if (!page) notFound();
  const { contentGroup, contentStyle }: { 
    contentGroup: 'hbx' | 'hb1' | 'hb3' | 'hb4' | 'main',
    contentStyle: 'hb-new' | 'hb-old' | 'menota-main'
  } = (slug => {
    if (slug && slug[0] == "handbook") {
      switch (slug[1]) {
        case "v1-0":
          return { contentGroup: "hb1", contentStyle: "hb-old" }
        case "v3":
          return { contentGroup: "hb3", contentStyle: "hb-new" };
        case "v4":
          return { contentGroup: "hb4", contentStyle: "hb-new" };
        default:
          return { contentGroup: "hbx", contentStyle: "menota-main" };
      }
    }
    return { contentGroup: 'main', contentStyle: 'menota-main' };
  })(slug);

  const MDX = page.data.body;

  return (
    <DocsPage 
      toc={contentStyle == "hb-old" ? undefined : page.data.toc} 
      full={page.data.full} 
      className={`bg-white dark:bg-black ${contentStyle}`}>
      {(() => {switch (contentGroup) {
        case "hb1":
          return;
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
        {(() => {switch (contentGroup) {
          case "hb1":
            return <LegacyPage slug={slug || []}/>;
          default:
            return (
              <MDX
                components={getMDXComponents({
                  // this allows you to link to other pages with relative file paths
                  a: createRelativeLink(source, page),
                })}
              />
            )
        }})()}
      </DocsBody>
    </DocsPage>
  );
}

export async function generateStaticParams() {
  return source.generateParams();
}

export async function generateMetadata(props: PageProps<'/[lang]/[[...slug]]'>): Promise<Metadata> {
  const { slug, lang } = await props.params;
  const page = source.getPage(slug, lang);
  if (!page) notFound();

  return {
    title: page.data.title,
    description: page.data.description,
    openGraph: {
      images: getPageImage(page).url,
    },
  };
}
