import { RootProvider } from 'fumadocs-ui/provider/next';
import '@/app/global.css';
import { Inter } from 'next/font/google';
import { translations } from '@/lib/layout.shared';
import type { Metadata } from 'next';
import { i18nProvider } from 'fumadocs-ui/i18n';

const inter = Inter({
  subsets: ['latin'],
});

export default async function Layout({ params, children }: LayoutProps<'/[lang]'>) {
  const { lang } = await params;
  return (
    <html lang={lang} className={inter.className} suppressHydrationWarning>
      <body className="flex flex-col min-h-screen bg-white dark:bg-black scroll-smooth">
        <RootProvider i18n={i18nProvider(translations, lang)}>
          {children}
        </RootProvider>
      </body>
    </html>
  );
}

export const metadata: Metadata = {
  title: {
    default: 'Menota',
    template: 'Menota | %s',
  }
}
