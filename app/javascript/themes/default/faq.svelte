<script>
  export let spina
  import HeroImages from "~/components/hero_images.svelte";
</script>

{#if spina.header_images?.images?.length}
  <div class="h-300px md:h-430px mb-20">
    {#key spina.page_title}
      <HeroImages height={200} images={spina.header_images.images}/>
    {/key}
  </div>
{:else}
  <div class="h-200px"></div>
{/if}


<main class="container">
  <h1>{spina.page_title}</h1>
  {#each spina.faq.content as faq}
    <div class="flex flex-col mt-8">
      <div class="flex-1">
        <details>
          <summary class="text-2xl font-bold cursor-pointer">
            {faq.parts[0].content}
          </summary>
          <div class="text-lg text-gray-700 mt-3">{@html faq.parts[1].content}</div>
      </details>
      </div>
    </div>
  {:else}
    Coming soon.
  {/each}
</main>

<style>
 h1 {
  text-align: center;
  letter-spacing: 0.3em;
  margin-bottom: 3rem;
  font-size: 2rem;
  text-transform: uppercase;
}
</style>