import prisma from '$lib/prisma';
import type { PageServerLoad } from './$types';

export const load = (async () => {
  const items = await prisma.items.findMany({
    include: {
      ratings: {
        select: {
          rating: true,
        },
      },
    },
  });
  return { items };
}) satisfies PageServerLoad;
