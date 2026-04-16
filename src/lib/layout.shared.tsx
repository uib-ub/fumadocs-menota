import { defineI18nUI } from 'fumadocs-ui/i18n';
import type { BaseLayoutProps } from 'fumadocs-ui/layouts/shared';
import { i18n } from '@/lib/i18n';

// fill this with your actual GitHub info, for example:
export const gitConfig = {
  user: 'fuma-nama',
  repo: 'fumadocs',
  branch: 'main',
};

export const i18nUI = defineI18nUI(i18n, {
  translations: {
    no: {
      displayName: 'Norsk',
      search: 'Søk',
      toc: 'På denne siden'
    },
    en: {
      displayName: 'English'
    }
  }
})

export function baseOptions(): BaseLayoutProps {
  return {
    nav: {
      title: ''
    },
    githubUrl: `https://github.com/${gitConfig.user}/${gitConfig.repo}`,
  };
}
