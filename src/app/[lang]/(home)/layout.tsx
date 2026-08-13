import { baseOptions } from '@/lib/layout.shared';
import { HomeLayout } from 'fumadocs-ui/layouts/home';
import './home.css';

export default async function Layout({ params, children }: LayoutProps<'/[lang]'>) {
  const base = baseOptions();
  const { lang } = await params;
  return (  
    <HomeLayout
      className='min-h-screen flex'
      {...base}
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
