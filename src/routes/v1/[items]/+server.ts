import prisma from '$lib/prisma';
import type { PageServerLoad } from './$types';

export const GET = (async ({ url }) => {
  const urlItemId = url.searchParams.get('q');
  const urlItemName = url.searchParams.get('name');
  let item;
  if (urlItemName) {
    item = await prisma.items.findMany({
      where: {
        name: {
          contains: urlItemName,
          mode: 'insensitive',
        },
      },
      include: {
        ratings: true,
      },
    });
  } else if (urlItemId == 'all') {
    item = await prisma.items.findMany({});
  } else {
    item = await prisma.items.findUnique({
      where: {
        itemid: urlItemId,
      },
      include: {
        suppliers: true,
        ratings: true,
        wishlistitems: true,
      },
    });
  }
  item = JSON.stringify(item, null, 2);
  return new Response(item, {
    headers: {
      'Content-Type':'application/json'
    }
  });
}) satisfies PageServerLoad;
