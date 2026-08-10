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
      <div className='homepage m-10'>
        {children}
      </div>
    </HomeLayout>
  );
}
