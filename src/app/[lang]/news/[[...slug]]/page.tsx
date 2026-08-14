import { getPageImage, source } from '@/lib/source';
import Image from 'next/image';
import { DocsBody, DocsPage } from 'fumadocs-ui/layouts/docs/page';
import { notFound, redirect } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';

export default async function Page(props: PageProps<'/[lang]/news/[[...slug]]'>) {
  const { lang, slug } = await props.params;
  if (!slug) {
    const newsPages = source.getPages().filter(page => page.slugs[0] == "news");
    const newest = newsPages.sort((a, b) => b.url.localeCompare(a.url))[0];
    if (!newest) redirect('/');
    redirect(newest.url);
  }
  const page = source.getPage(["news", ...slug], lang);
  if (!page) notFound();
  const MDX = page.data.body;

  return (
    <DocsPage 
      breadcrumb={{enabled: false}}
      full={page.data.full} 
      className="docspage menota-main"
    >
      <div className='flex flex-wrap mb-5 dark:invert'>
        <Image src='/images/Menota-banner.gif' alt='Menota banner' width={300} height={65}/>
        <Image src='/images/Menota-banner-3.gif' alt='Menota banner' width={304} height={64}/>
      </div>
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
