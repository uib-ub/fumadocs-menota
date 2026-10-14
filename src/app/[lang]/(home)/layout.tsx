import { baseOptions } from '@/lib/layout.shared';
import { HomeLayout } from 'fumadocs-ui/layouts/home';

export default async function Layout({ params, children }: LayoutProps<'/[lang]'>) {
  const lang = (await params).lang as "en" | "no";
  const base = baseOptions(lang);
  return (  
    <HomeLayout
      className='homepage min-h-screen flex'
      {...base}
    >
      <div>
        <div className='fixed inset-0 bg-[url("/images/nordr.jpeg")] bg-cover bg-right -z-10'/>
        <div className='
          fixed inset-0 -z-9
          bg-linear-to-r 
          from-slate-100/80 to-slate-100/60
          md:via-slate-100/80 md:to-slate-100/50
          xl:via-slate-100/70 xl:to-slate-50/10
          dark:from-slate-900/80 dark:to-slate-900/60
          md:dark:via-slate-900/80 md:dark:to-slate-900/50
          xl:dark:via-slate-900/70 xl:dark:to-slate-900/10
        '/>
        {children}
      </div>
    </HomeLayout>
  );
}
