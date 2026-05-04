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
    contentGroup: 'html' | 'hb2' | 'hb3' | 'hb4' | 'main',
    contentStyle: 'hb-new' | 'old' | 'menota-main'
  } = (slug => {
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
    if (slug && slug.join("/") == "documents/statutes/draft")
      return { contentGroup: 'html', contentStyle: 'old'};
    return { contentGroup: 'main', contentStyle: 'menota-main' };
  })(slug);

  const MDX = page.data.body;

  return (
    <DocsPage 
      toc={contentStyle == "old" ? undefined : page.data.toc} 
      full={page.data.full} 
      className={`
        bg-white dark:bg-black 
        [&_h1]:text-gray-500 [&_h1]:dark:text-gray-300 [&_h1]:text-2xl
        [&_h2]:text-gray-500 [&_h2]:dark:text-gray-300 [&_h2]:text-xl
        [&_h3]:text-gray-500 [&_h3]:dark:text-gray-300 [&_h3]:text-lg
        [&_h4]:text-gray-500 [&_h4]:dark:text-gray-300 [&_h4]:text-base
        [&_h5]:text-gray-500 [&_h5]:dark:text-gray-300 [&_h5]:text-sm [&_h5]:font-bold
        [&_th]:bg-blue-50 [&_th]:text-gray-600 [&_th]:dark:bg-blue-950 [&_th]:dark:text-gray-200
        [&_td]:bg-white [&_td]:dark:bg-black
        [&_ol_a]:text-blue-700 [&_ol_a]:dark:text-orange-300
        [&_p_a]:text-blue-700 [&_p_a]:dark:text-orange-300
        [&_td_a]:text-blue-700 [&_td_a]:dark:text-orange-300
        [&_ul_a]:text-blue-700 [&_ul_a]:dark:text-orange-300
        ${contentStyle}`
      }>
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
        {(() => {switch (contentGroup) {
          case "html":
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
