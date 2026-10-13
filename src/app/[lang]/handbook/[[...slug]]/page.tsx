import { getPageImage, source } from '@/lib/source';
import Image from 'next/image';
import { DocsBody, DocsPage } from 'fumadocs-ui/layouts/notebook/page';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import { getCustomPage } from '@/utils/custom-page';
import Footer from '@/components/footer';
import AutoImage from '@/components/auto-image';

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
      footer={{items: {}}}
      //slots={{ footer: contentGroup == "html" ? null : <Footer context="handbook"/> }}
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
            <div className='mb-5 border-b border-solid border-slate-900 dark:border-slate-100 pb-3'>
              <div className='text-3xl font-semibold text-blue-900 dark:text-blue-400'>
                Menota Handbook {contentGroup == "hb3" ? "3.0" : "4.0 β"}
              </div>
              <div className='text-lg text-green-800 dark:text-green-300'>
                Guidelines for the electronic encoding of<br/>
                Medieval Nordic primary sources
              </div>
            </div>
          );
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
      { contentGroup == "html" ? null : <Footer context="handbook"/> }
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
