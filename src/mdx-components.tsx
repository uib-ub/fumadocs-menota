import defaultMdxComponents from 'fumadocs-ui/mdx';
import InlineImage from '@/components/inline-image';
import AutoImage from '@/components/auto-image';
import Caption from '@/components/caption';
import { Card, Cards } from '@/components/cards';
import DisplayFrame from '@/components/display-frame';
import EmbeddedPage from '@/components/embedded-page';
import Figure from '@/components/figure';
import Glyph from '@/components/glyph';
import Hero from '@/components/hero';
import HI from '@/components/hi';
import LitItem from '@/components/lit-item';
import Quote from '@/components/quote';
import Tile from '@/components/tile';
import UnderConstruction from '@/components/underconstruction';
import { Att, E, Val } from '@/components/xml';
import Link from 'next/link';
import Image from 'next/image';
import type { MDXComponents } from 'mdx/types';

export function getMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...defaultMdxComponents,
    Att,
    AutoImage,
    Caption,
    Card,
    Cards,
    DisplayFrame,
    E,
    EmbeddedPage,
    Figure,
    Glyph,
    Hero,
    HI,
    Image,
    InlineImage,
    LitItem,
    Link,
    Quote,
    Tile,
    UnderConstruction,
    Val,
    ...components,
  };
}
