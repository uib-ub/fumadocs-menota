import { defineConfig, defineDocs } from 'fumadocs-mdx/config';
import { metaSchema, pageSchema } from 'fumadocs-core/source/schema';
import { remarkHeading } from 'fumadocs-core/mdx-plugins';
import { z } from 'zod';

// You can customise Zod schemas for frontmatter and `meta.json` here
// see https://fumadocs.dev/docs/mdx/collections
export const docs = defineDocs({
  dir: 'content/',
  docs: {
    schema: {
      ...pageSchema,
      frontmatter: z.object({
        changeLog: z.array(z.object({
          date: z.string(),
          author: z.string(),
          changes: z.array(z.string())
        }))
      })
    },
    postprocess: {
      includeProcessedMarkdown: true,
    },
  },
  meta: {
    schema: metaSchema,
  },
});

export default defineConfig({
  mdxOptions: {
    rehypeCodeOptions: {
      themes: {
        light: 'github-light',
        dark: 'github-dark',
      },
      inline: 'tailing-curly-colon'
    },
    remarkPlugins: [
      [remarkHeading, { 
        generateId: false,
        generateToc: true
      }]
    ]
  },
});
