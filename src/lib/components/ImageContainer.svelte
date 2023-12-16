<script lang="ts">
  export let itemPhotos: string[];

  $: currentHoveredImage = itemPhotos[0];
  $: currentImageSelected = null;

  const handleHoveredImage = (element) => {
    const target = element.target;

    if (currentImageSelected && currentImageSelected !== target) {
      currentImageSelected.classList.remove("border-gray-950", "border-l-2");
    }

    target.classList.add("border-gray-950", "border-l-2");

    currentImageSelected = target;
    currentHoveredImage = target.src;
  };
</script>

<section class="flex">
  <section class="flex flex-col w-20 gap-4">
    {#each itemPhotos as photo}
      <img src={photo} alt="item-photo" on:mouseover={handleHoveredImage} />
    {/each}
  </section>
  <section class="h-96 w-96 mx-8">
    <img src={currentHoveredImage} alt="current-picked-photo" class="h-full" />
  </section>
</section>
