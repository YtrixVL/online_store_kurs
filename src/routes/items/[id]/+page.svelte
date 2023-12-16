<script lang="ts">
  import Item from '$lib/components/Item.svelte';
  import type { PageData } from './$types';
  export let data: PageData;
</script>

<Item item ={data.item} />
