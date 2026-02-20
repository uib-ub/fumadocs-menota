import defaultMdxComponents from 'fumadocs-ui/mdx';
import InlineImage from '@/components/inline-image';
import AutoImage from '@/components/auto-image';
import type { MDXComponents } from 'mdx/types';
import Link from 'next/link';
import Image from 'next/image';

export function getMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...defaultMdxComponents,
    AutoImage,
    Image,
    InlineImage,
    Link,
    ...components,
  };
}
