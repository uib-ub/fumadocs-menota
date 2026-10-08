import { getPageImage, source } from '@/lib/source';
import Image from 'next/image';
import { DocsBody, DocsPage } from 'fumadocs-ui/layouts/notebook/page';
import { notFound, redirect } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import Footer from '@/components/footer';
import AutoImage from '@/components/auto-image';
import { getCustomPage } from '@/utils/custom-page';

import type { Metadata } from 'next';

export default async function Page(props: PageProps<'/[lang]/news/[[...slug]]'>) {
  const { lang, slug } = await props.params;
  if (!slug) {
    const newsPages = source.getPages().filter(page => page.slugs[0] == "news");
    const newest = newsPages.sort((a, b) => b.url.localeCompare(a.url))[0];
    if (!newest) redirect('/');
    redirect(newest.url);
  }
  const page = getCustomPage({ slug, lang, basePath: "news" });
  if (!page) notFound();
  const MDX = page.data.body;

  return (
    <DocsPage 
      toc={page.data.toc}
      breadcrumb={{enabled: false}}
      full={page.data.full} 
      footer={{items: {}}}
      //slots={{ footer: <Footer context="news"/> }}
      className="docspage menota-main"
    >
      <div className='flex flex-wrap mb-5 dark:invert'>
        <AutoImage src='/images/Menota-banner-new.svg' className="
          border
          p-1 rounded-lg
          sm:p-3 sm:rounded-xl
          md:p-10 md:rounded-3xl 
          bg-white/80 backdrop-blur-xs
        "/>
      </div>
      <DocsBody>
        <MDX
          components={getMDXComponents({
            // this allows you to link to other pages with relative file paths
            a: createRelativeLink(source, page),
          })}
        />
      </DocsBody>
      <Footer context="news"/>
    </DocsPage>
  );
}

export async function generateStaticParams() {
  return source.generateParams();
}

export async function generateMetadata(props: PageProps<'/[lang]/news/[[...slug]]'>): Promise<Metadata> {
  const { slug, lang } = await props.params;
  const page = source.getPage(["news", ...slug || []], lang);
  if (!page) notFound();

  return {
    title: page.data.title,
    description: page.data.description,
    openGraph: {
      images: getPageImage(page).url,
    },
  };
}
