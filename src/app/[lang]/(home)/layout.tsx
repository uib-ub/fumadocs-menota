import { baseOptions } from '@/lib/layout.shared';
import { HomeLayout } from 'fumadocs-ui/layouts/home';
import './home.css';

const translations: Record<
  "archive" | "hb" | "main_archive" | "news" | "org" | "other_archives",
  {en: string, no: string}
> = {
  archive: {
    en: "Text Archive",
    no: "Tekstarkiv"
  },
  hb: {
    en: "Handbook",
    no: "Håndbok"
  },
  main_archive: {
    en: "Main Archive",
    no: "Hovedarkiv"
  },
  news: {
    en: "News",
    no: "Nyheter"
  },
  org: {
    en: "Organisation",
    no: "Organisasjon"
  },
  other_archives: {
    en: "Other archives",
    no: "Andre arkiv"
  }
}

export default async function Layout({ params, children }: LayoutProps<'/[lang]'>) {
  const base = baseOptions();
  const lang = (await params).lang as "en" | "no";
  return (  
    <HomeLayout
      className='min-h-screen flex'
      {...base}
      links={[
        {
          text: translations.news[lang],
          url: '/news'
        },
        {
          type: 'menu',
          text: translations.archive[lang],
          items: [
            {
              text: translations.main_archive[lang],
              url: 'https://clarino.uib.no/menota/catalogue/menota'
            },
            {
              text: translations.other_archives[lang],
              url: '/other/archives'
            }
          ]
        },
        {
          type: 'menu',
          text: translations.hb[lang],
          items: [
            {
              text: `${translations.hb[lang]} 1.0`,
              url: '/handbook/v1-0'
            },
            {
              text: `${translations.hb[lang]} 1.1`,
              url: '/handbook/v1-1'
            },
            {
              text: `${translations.hb[lang]} 2`,
              url: '/handbook/v2'
            },
            {
              text: `${translations.hb[lang]} 3`,
              url: '/handbook/v3'
            }
          ]
        },
        {
          type: 'menu',
          text: translations.org[lang],
          items: []
        }
      ]}
    >
      <div>
        <div className='fixed inset-0 bg-[url("/images/nordr.jpeg")] bg-cover bg-right -z-10'/>
        <div className='
          fixed inset-0 -z-9
          bg-linear-to-r from-slate-950/80 via-slate-900/60 to-slate-50/10
        '/>
        {children}
      </div>
    </HomeLayout>
  );
}
