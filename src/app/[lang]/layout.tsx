import { RootProvider } from 'fumadocs-ui/provider/next';
import '@/app/global.css';
import { Inter } from 'next/font/google';
import { baseOptions, i18nUI } from '@/lib/layout.shared';

const inter = Inter({
  subsets: ['latin'],
});

export default async function Layout({ params, children }: LayoutProps<'/[lang]'>) {
  const base = baseOptions();
  const { lang } = await params;
  return (  
    <html lang={lang} className={inter.className} suppressHydrationWarning>
      <body className="flex flex-col min-h-screen bg-white dark:bg-black">
        <RootProvider i18n={i18nUI.provider(lang)}>
          {children}
        </RootProvider>
      </body>
    </html>
  );
}
