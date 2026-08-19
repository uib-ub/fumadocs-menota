import { defineI18nUI } from 'fumadocs-ui/i18n';
import type { BaseLayoutProps } from 'fumadocs-ui/layouts/shared';
import { i18n } from '@/lib/i18n';

export const gitConfig = {
  user: 'uib-ub',
  repo: 'fumadocs-menota',
  branch: 'main',
};

export const i18nUI = defineI18nUI(i18n, {
  translations: {
    no: {
      displayName: 'Norsk',
      search: 'Søk',
      toc: 'På denne siden',
      previousPage: 'Forrige side',
      nextPage: 'Neste side'
    },
    en: {
      displayName: 'English'
    }
  }
})

export function baseOptions(): BaseLayoutProps {
  return {
    nav: {
      title: <span className='pl-2 text-green-800 dark:text-green-300 font-bold font-sans'>www.menota.org</span>
    },
    githubUrl: `https://github.com/${gitConfig.user}/${gitConfig.repo}`,
    i18n: true,
  };
}
