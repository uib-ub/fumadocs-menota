import { getPageImage, source } from '@/lib/source';
import Image from 'next/image';
import { DocsBody, DocsDescription, DocsPage, DocsTitle } from 'fumadocs-ui/layouts/docs/page';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';

export default async function Page(props: PageProps<'/[[...slug]]'>) {
  const params = await props.params;
  const page = source.getPage(params.slug);
  if (!page) notFound();
  const contentType: 'hbx' | 'hb3' | 'hb4' | 'main' = (slug => {
    if (slug && slug[0] == "handbook") {
      switch (slug[1]) {
        case "v3":
          return "hb3";
        case "v4":
          return "hb4";
        default:
          return "hbx";
      }
    }
    return 'main';
  })(params.slug);

  const MDX = page.data.body;

  return (
    <DocsPage toc={page.data.toc} full={page.data.full} className={`bg-white dark:bg-black ${contentType}`}>
      {(() => {switch (contentType) {
        case "hb3":
          return (
            <div className='mb-5 border-b border-solid border-black pb-3'>
              <div style={{fontSize: '1.8em', fontWeight: '600', color: 'rgb(24, 41, 131)'}}>
                Menota Handbook 3.0
              </div>
              <div style={{fontSize: '1.1em', fontWeight: '400', color: 'rgb(16, 93, 71)'}}>
                Guidelines for the electronic encoding of<br/>
                Medieval Nordic primary sources
              </div>
            </div>
          );
        case "hb4":
          return (
            <div className='mb-5 border-b border-solid border-black pb-3'>
              <div style={{fontSize: '1.8em', fontWeight: '600', color: 'rgb(24, 41, 131)'}}>
                Menota Handbook 4.0 β 
              </div>
              <div style={{fontSize: '1.1em', fontWeight: '400', color: 'rgb(16, 93, 71)'}}>
                Guidelines for the electronic encoding of<br/>
                Medieval Nordic primary sources
              </div>
            </div>
          );
        case "main":
          return (
            <div className='flex flex-wrap mb-5'>
              <Image src='/images/Menota-banner.gif' alt='Menota banner' width={300} height={65}/>
              <Image src='/images/Menota-banner-3.gif' alt='Menota banner' width={304} height={64}/>
            </div>
          );
      }})()}
      {/*
      <DocsTitle>{page.data.title}</DocsTitle>
      <DocsDescription className="mb-0">{page.data.description}</DocsDescription>
      <div className="flex flex-row gap-2 items-center border-b pb-6">
        <LLMCopyButton markdownUrl={`${page.url}.mdx`} />
        <ViewOptions
          markdownUrl={`${page.url}.mdx`}
          githubUrl={`https://github.com/${gitConfig.user}/${gitConfig.repo}/blob/${gitConfig.branch}/content/docs/${page.path}`}
        />
      </div> 
      */}
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

export async function generateMetadata(props: PageProps<'/[[...slug]]'>): Promise<Metadata> {
  const params = await props.params;
  const page = source.getPage(params.slug);
  if (!page) notFound();

  return {
    title: page.data.title,
    description: page.data.description,
    openGraph: {
      images: getPageImage(page).url,
    },
  };
}
