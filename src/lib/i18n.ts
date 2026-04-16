import { defineI18n } from "fumadocs-core/i18n";

export const i18n = defineI18n({
    defaultLanguage: 'no',
    languages: ['no', 'en', 'da', 'de', 'is', 'se'],
    hideLocale: 'default-locale',
    fallbackLanguage: 'no',
    parser: 'dot'
})