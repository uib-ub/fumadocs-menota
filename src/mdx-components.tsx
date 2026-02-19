import defaultMdxComponents from 'fumadocs-ui/mdx';
import InlineImage from '@/components/inline-image';
import type { MDXComponents } from 'mdx/types';
import Link from 'next/link';

export function getMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...defaultMdxComponents,
    InlineImage,
    Link,
    ...components,
  };
}
