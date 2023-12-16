<script lang="ts">
  import type { PageData } from '../../../.svelte-kit/types/src/routes/$types.d.ts';
  import { addSpaceInString } from '$lib/utils/helpers.js';
  import RatingReadOnly from './RatingReadOnly.svelte';

  export let item: PageData;

  let sum: number;
  let count: number;
  let avg: number;
  let itemId: string;
  let itemThumb: string;
  let itemName: string;
  let itemPrice: string;
  let itemRatingsArray: number[] = [];

  if (Array.isArray(item)) {
    itemPrice = addSpaceInString(item[0].price.toString());
    itemId = item[0].itemid;
    if (Array.isArray(item[0].photo)) {
      itemThumb = item[0].photo[0];
    } else {
      itemThumb = item[0].photo[0];
    }
    itemName = item[0].name;
    item[0].ratings.forEach((element) => {
      itemRatingsArray.push(element.rating);
    });
  } else {
    itemPrice = addSpaceInString(item.price.toString());
    itemId = item.itemid;
    itemThumb = item.photo;
    itemName = item.name;
    item.ratings.forEach((element) => {
      itemRatingsArray.push(element.rating);
    });
  }
  if (Array.isArray(itemThumb)) {
    itemThumb = itemThumb[0];
  }

  sum = itemRatingsArray.reduce((a, b) => a + b, 0);
  count = itemRatingsArray.length;
  avg = sum / count || 0;

  const handleitemChange = () => {
    window.location.href = `/items/${itemId}`;
  };
</script>

<section class="w-full flex gap-2">
  <div class="relative h-16 flex justify-center w-32">
    <img src={itemThumb} alt="thumb-{itemName}" class="h-full" />
  </div>
  <section class="flex flex-col justify-start w-full gap-2">
    <a
      on:click={handleitemChange}
      class="hover:text-blue-600 w-full h-max hover:cursor-pointer"
    >
      {itemName}
    </a>
    <span class="font-semibold text-blue-600">{itemPrice} &#8381;</span>
  </section>
</section>
