import prisma from '$lib/prisma';
import type { PageServerLoad } from './$types';

export const load = (async ({ params: { id } }) => {
  const item = await prisma.items.findUnique({
    where: { itemid: id },
    include: {
      ratings: {
        select: {
          rating: true,
        },
      },
      suppliers: {
        select: {
          supplierid: true,
          companyname: true,
          logo: true,
        },
      },
    },
  });

  return { item };
}) satisfies PageServerLoad;
