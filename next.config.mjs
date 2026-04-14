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
        source: '/legacy/handbook/v1/handbok_1/:path*.gif',
        destination: '/images/hb1/:path*.gif'
      },
      {
        source: '/legacy/handbook/v1/:id.xhtml',
        destination: '/legacy/handbook/v1/:id.html'
      }
    ];
  },
};

export default withMDX(config);
