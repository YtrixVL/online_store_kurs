<script lang="ts">
  import type { PageData } from "../../routes/$types.js";
  import {
    itemEnumValueToString,
    addSpaceInString,
  } from "$lib/utils/helpers";

  // import ImageContainer from "./ImageContainer.svelte.js";
  import ImageContainer from "./ImageContainer.svelte"
  import RatingReadOnly from "./RatingReadOnly.svelte";

  export let item: PageData;

  let itemRatingsArray: number[] = [];
  let sum: number;
  let count: number;
  let avg: number;

  $: isHearted = false;
  const fillHeart = () => (isHearted = !isHearted);

  item.ratings.forEach((element) => {
    itemRatingsArray.push(element.rating);
  });

  sum = itemRatingsArray.reduce((a, b) => a + b, 0);
  count = itemRatingsArray.length;
  avg = sum / count || 0;

  $: supplierLogo = item.suppliers.logo;
  $: supplierName = item.suppliers.companyname;
  $: itemId = item.itemid;
  $: itemThumb = item.photo[0];
  $: itemName = item.name;
  $: itemColor = item.color;
  $: itemInStock = item.instock;
  $: itemDiscountAvailable = true;
  $: itemDiscountAmount = item.discount || 8;

  $: itemType = itemEnumValueToString(item.itemtype);
  $: itemPrice = item.price;
  $: itemPriceString = addSpaceInString(item.price.toString());
  console.log(item.suppliers)
</script>

<svelte:head>
  <title>
    {supplierName}
    {itemName}
    </title>
</svelte:head>

<section class="flex flex-col w-8/12 my-0 mx-auto box-border p-8 text-gray-700">
  <h1 class=" w-full pb-4 font-bold text-3xl">
    {itemType}
    {supplierName}
    {itemName}
  </h1>
  <section class="w-full bg-white p-8 text-gray-700">
    <section class="flex">
      <ImageContainer itemPhotos={item.photo} />
      <section class="flex flex-col w-full px-6">
        <section class="flex w-full h-12 items-start justify-around">
          <section class="w-4/5">
            <span
              >Цвет: {itemColor}, размер: </span
            >
            <a href="#specs" class="no-underline text-blue-600">подробнее</a>
          </section>
          <section class="w-1/5 flex justify-end mx-1">
            <img src={supplierLogo} alt="supplier-logo" class="h-full" />
          </section>
        </section>
        <section class="flex w-full py-2">
          <RatingReadOnly rating={avg} ratingCount={count} height={5} />
        </section>
        <section class="mt-4 w-full rounded-lg p-3 shadow-md">
          <section class="flex items-end gap-x-1">
            <span class="font-semibold text-2xl text-blue-600"
              >{itemPriceString} &#8381;</span
            >
            {#if itemDiscountAvailable}
              <span class="text-sm text-gray-600 line-through"
                >{addSpaceInString(
                  parseInt(
                    itemPrice + (itemPrice / 100) * itemDiscountAmount
                  ).toString()
                )}</span
              >
            {/if}
          </section>
        </section>
      </section>
    </section>
  </section>
</section>

<style>
</style>
