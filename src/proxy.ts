import { createI18nMiddleware } from "fumadocs-core/i18n/middleware";
import { i18n } from "@/lib/i18n";

export default createI18nMiddleware(i18n);

export const config = {
    // Matcher ignoring `/_next/` and `/api/`
    matcher: [
        '/((?!.*\\.(?:css|dtd|ent|gif|pdf|rng|txt|xml|xsl)$|images|legacy|api|_next/static|_next/image|favicon.ico).*)'
    ]
}