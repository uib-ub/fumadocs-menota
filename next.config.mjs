import { createMDX } from 'fumadocs-mdx/next';

const withMDX = createMDX();

/** @type {import('next').NextConfig} */
const config = {
  reactStrictMode: true,
  async rewrites() {
    return [
      {
        source: '/docs/:path*.mdx',
        destination: '/llms.mdx/docs/:path*',
      },
      {
        source: '/legacy/handbook/v1/:path*.css',
        destination: '/:path*.css'
      },
      {
        source: '/legacy/documents/statutes/:id.gif',
        destination: '/images/:id.gif'
      },
      {
        source: '/legacy/handbook/v1/:id.gif',
        destination: '/images/:id.gif'
      },
      {
        source: '/legacy/handbook/v1/handbok_1/:path*.gif',
        destination: '/images/hb1/:path*.gif'
      },
      {
        source: '/legacy/handbook/v1/handbok_1/:path*.jpg',
        destination: '/images/hb1/:path*.jpg'
      }
    ];
  },
  async redirects() {
    return [
      {
        source: '/forside.xhtml',
        destination: '/',
        permanent: true
      },
      {
        source: '/HB2_index.xml',
        destination: '/handbook/v2',
        permanent: true
      },
      {
        source: '/legacy/handbook/v1/HB1-0_:id.xhtml',
        destination: '/handbook/v1-0/:id',
        permanent: true
      },
      {
        source: '/legacy/handbook/v1/HB1-1_:id.xhtml',
        destination: '/handbook/v1-1/:id',
        permanent: true
      },
      {
        source: '/legacy/handbook/v1/HB1-1-1_:id.xhtml',
        destination: '/handbook/v1-1/:id',
        permanent: true
      },
      {
        source: '/legacy/handbook/v1/HB1_:id.xhtml',
        destination: '/handbook/v1-0/:id',
        permanent: true
      },
      {
        source: '/legacy/handbook/v1/:path*.dtd',
        destination: '/:path*.dtd',
        permanent: true
      },
      {
        source: '/legacy/handbook/v1/:path*.ent',
        destination: '/:path*.ent',
        permanent: true
      },
      {
        source: '/legacy/handbook/v1/:id.xls',
        destination: '/handbook/v1/:id.xls',
        permanent: true
      },
      {
        source: '/handbook/:version/contents',
        destination: '/handbook/:version',
        permanent: true
      }
    ]
  }
};

export default withMDX(config);
