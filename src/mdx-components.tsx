import defaultMdxComponents from 'fumadocs-ui/mdx';
import InlineImage from '@/components/inline-image';
import AutoImage from '@/components/auto-image';
import Caption from '@/components/caption';
import Figure from '@/components/figure';
import Glyph from '@/components/glyph';
import Quote from '@/components/quote';
import type { MDXComponents } from 'mdx/types';
import Link from 'next/link';
import Image from 'next/image';

export function getMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...defaultMdxComponents,
    AutoImage,
    Caption,
    Figure,
    Glyph,
    Image,
    InlineImage,
    Link,
    Quote,
    ...components,
  };
}
