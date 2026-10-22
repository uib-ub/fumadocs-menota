import type { BaseLayoutProps } from 'fumadocs-ui/layouts/shared';
import { i18n } from '@/lib/i18n';
import { navbarItems } from '@/utils/navbar-items';
import { uiTranslations } from 'fumadocs-ui/i18n';

export const gitConfig = {
  user: 'uib-ub',
  repo: 'fumadocs-menota',
  branch: 'main',
};

export const translations = i18n
  .translations()
  .extend(uiTranslations())
  .add({
    en: {
      displayName: 'English'
    },
    no: {
      displayName: 'Norsk',
      "Choose a language(language switcher)": 'Velg språk:',
      "Choose a language(language switcher)(aria-label)": 'Velg språk'
    }
  });

export function baseOptions(lang: "en" | "no"): BaseLayoutProps {
  return {
    nav: {
      title: <span className='pl-2 text-green-800 dark:text-green-300 font-bold font-sans'>www.menota.org</span>
    },
    links: navbarItems(lang),
    githubUrl: `https://github.com/${gitConfig.user}/${gitConfig.repo}`,
    i18n: true,
    searchToggle: {
      enabled: false
    }
  };
}
