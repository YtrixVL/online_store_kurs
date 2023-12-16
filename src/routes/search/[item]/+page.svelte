<script lang="ts">
  import SearchFilters from '$lib/components/SearchFilters.svelte';
  import SearchResult from '$lib/components/SearchResult.svelte';
  import type { PageData } from '../[item]/$types';
  export let data: PageData;
</script>

<svelte:head>
  <title>Результаты поиска</title>
</svelte:head>
<section class="flex justify-center gap-x-4 p-4">
  <SearchFilters />
  <section class="flex flex-col gap-4 mt-6 mb-4">
    {#each data.items as item (item.itemid)}
      <SearchResult {item} rating={item.itemid} />
    {/each}
  </section>
</section>
