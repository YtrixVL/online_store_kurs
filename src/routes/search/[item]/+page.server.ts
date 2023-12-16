import prisma from '$lib/prisma';
import type { PageServerLoad } from '../$types';

export const load = (async ({ url }) => {
  let searchQuery: any = url.searchParams.get('q');
  const items = await prisma.items.findMany({
    where: {
      OR: [
        {
          name: {
            contains: searchQuery,
            mode: 'insensitive',
          },
        },
        {
          color: {
            contains: searchQuery,
            mode: 'insensitive',
          },
        },
      ],
    },
    include: {
      ratings: true,
    },
  });

  return { items };
}) satisfies PageServerLoad;
