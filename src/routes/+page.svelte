<script lang="ts">
  import type { PageData } from './$types';
  export let data: PageData;
</script>

<svelte:head>
  <title>YanPavlov</title>
</svelte:head>

<slot>
  <div>
    {#each data.items as item (item.itemid)}
      <a href="items/{item.itemid}" class="text-red-500"
        >{item.name}</a
      >
    {/each}
  </div>
</slot>
