import { getPageImage, source } from '@/lib/source';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import type { Metadata } from 'next';
import Footer from '@/components/footer';
import { getCustomPage } from '@/utils/utils';

export default async function Page(props: PageProps<'/[lang]'>) {
  const { lang } = await props.params;
  const page = getCustomPage({ slug: undefined, lang })
  //const page = source.getPage(undefined, lang);
  if (!page) notFound();
  const { contentGroup, contentStyle } = { 
    contentGroup: 'main',
    contentStyle: 'menota-main'
  };

  const MDX = page.data.body;

  return (
    <>
      <MDX
          components={getMDXComponents({
              // this allows you to link to other pages with relative file paths
              a: createRelativeLink(source, page),
          })}
      />
      <Footer log={page.data.changeLog} lang={lang} className='bg-white/80 p-10 pb-15'/>
    </>
  );
}

export async function generateStaticParams() {
  return source.generateParams();
}

export async function generateMetadata(props: PageProps<'/[lang]'>): Promise<Metadata> {
  const { lang } = await props.params;
  const page = source.getPage(undefined, lang);
  if (!page) notFound();

  return {
    title: page.data.title,
    description: page.data.description,
    openGraph: {
      images: getPageImage(page).url,
    },
  };
}
