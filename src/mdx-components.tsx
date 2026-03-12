import defaultMdxComponents from 'fumadocs-ui/mdx';
import InlineImage from '@/components/inline-image';
import AutoImage from '@/components/auto-image';
import Caption from '@/components/caption';
import DisplayFrame from '@/components/display-frame';
import Figure from '@/components/figure';
import Glyph from '@/components/glyph';
import LitItem from '@/components/lit-item';
import Quote from '@/components/quote';
import { E } from '@/components/xml';
import type { MDXComponents } from 'mdx/types';
import Link from 'next/link';
import Image from 'next/image';

export function getMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...defaultMdxComponents,
    AutoImage,
    Caption,
    DisplayFrame,
    Figure,
    Glyph,
    Image,
    InlineImage,
    LitItem,
    Link,
    Quote,
    E,
    ...components,
  };
}
