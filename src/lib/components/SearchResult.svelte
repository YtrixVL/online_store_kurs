<script lang="ts">
  import type { PageData } from "../../../.svelte-kit/types/src/routes/$types.d.ts";

  import {
    itemEnumValueToString,
    addSpaceInString,
  } from "$lib/utils/helpers";

  import RatingReadOnly from "./RatingReadOnly.svelte";
  import ButtonLike from "./ButtonLike.svelte";
  import ButtonBuy from "./ButtonBuy.svelte";

  export let item: PageData;

  let itemId = item.itemid;
  let itemThumb = item.photo[0];
  let itemName = item.name;
  let itemColor = item.color;
  let itemInStock: boolean = item.instock;
  let itemDiscountAvailable: boolean = true;
  let itemDiscountAmount = item.discount || 8;
  let itemRatingsArray = [];
  item.ratings.forEach((element) => {
    itemRatingsArray.push(element.rating);
  });
  const sum = itemRatingsArray.reduce((a, b) => a + b, 0);
  const count = itemRatingsArray.length;
  const avg = sum / count || 0;
  let itemType = itemEnumValueToString(item.itemtype);
  let itemPrice = item.price;
  let itemPriceString = addSpaceInString(item.price.toString());

</script>

<section class="w-full flex bg-white p-5 rounded-lg">
  <div class="relative h-52 flex justify-center w-64">
    <img src={itemThumb} alt="thumb-{itemName}" />
    {#if itemDiscountAvailable}
      <span
        class="absolute rounded-3xl bg-blue-500 text-gray-50 p-2 text-xs right-36 top-40"
        >-{itemDiscountAmount}%</span
      >
    {/if}
  </div>

  <section class="flex justify-between w-full p-1 flex-col rounded-xl">
    <a
      href="/items/{itemId}"
      class="hover:text-blue-600 w-full h-max pb-12"
      >{itemType}
      {itemName}
      {itemColor} []</a
    >
    <section class="flex flex-col justify-between p-1 items-end">
      <section class="flex gap-x-4 justify-between w-full">
        <section class="flex flex-col w-full">
          {#if itemDiscountAvailable}
            <span class="text-sm text-gray-600 line-through"
              >{addSpaceInString(
                parseInt(
                  itemPrice + (itemPrice / 100) * itemDiscountAmount,
                ).toString(),
              )}</span
            >
          {/if}
          <span class="font-semibold text-2xl text-blue-600"
            >{itemPriceString} &#8381;</span
          >
          <section
            class="w-full flex justify-between pr-8 text-md text-gray-600 items-end"
          >
            <span
              >В наличии:
              {#if itemInStock}
                <span class=" text-green-600">да</span>
              {:else}
                <span class="text-red-600">нет</span>
              {/if}
            </span>
            <RatingReadOnly
              rating={avg.toFixed(1)}
              ratingCount={count}
              height={5}
            />
          </section>
        </section>
        <section class="flex gap-x-4 items-end">
          <ButtonLike />
          <ButtonBuy />
        </section>
      </section>
    </section>
  </section>
</section>
