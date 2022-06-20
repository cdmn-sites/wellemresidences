<script>
  import HeroImages from "../../components/hero_images.svelte";
  import Cycler from "../../components/cycler.svelte";
  import Paralax from "../../components/paralax.svelte";
  import glightbox from 'glightbox'
  import { onMount } from "svelte";
  export let spina

  onMount(() => {
    glightbox()
  })
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
  <div class="tagline2">

  </div>
  

  {#each spina.sections?.content || [] as section, i}
    {@const title = section.parts[0].content}
    {@const images = section.parts[1].images}
    {@const text = section.parts[2].content}
    {@const style = section.parts[3]?.value}

    {#if style == 'parallax'}
      <section relative class:odd={i % 2 == 1} class="spina mb-20 lg:h-140 xl:h-180">
        <h1>{title}</h1>
        {#if images?.length}
          <div class:right-0={i % 2 == 1} class="relative lg:absolute aspect-video lg:w-7/10  overflow-hidden">
            <Paralax scale={1.05} y={120}>
              <Cycler let:current>
                {#each images as img, i}
                  <img alt={img.alt} class:active={current == i} class="lg:absolute object-cover w-full h-full cycle_image" src="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" />
                {/each}
              </Cycler>
            </Paralax>
          </div>
        {/if}
        <Paralax y={-100}>
          <div class:right-0={i % 2 == 0} class="nice relative -top-70px lg:text-size-lg xl:text-size-xl xl:w-12/10 lg:max-w-500px xl:max-w-700px shadow-2xl bg-light/90 p-6 lg:absolute lg:top-140px xl:top-300px">
            {@html text}
          </div>
        </Paralax>
      </section>
    {:else if style == 'mosaic'}
      <section mb-28>
          <h1>{title}</h1>
          <div class="md:grid gap-4 grid-cols-3">
            {#if images[0]}
              <img alt={images[0].alt}  class="object-cover w-full h-full" src="/rails/active_storage/blobs/{images[0].signed_blob_id}/{images[0].filename}" />
            {/if}
            {#if text}
            <div class="spina py-5 md:p-4 lg:p-6 md:bg-white md:shadow leading-6 tracking-wide lg:text-size-4 2xl:text-size-lg 2xl:leading-7">
              {@html text}
            </div>
            {/if}
            {#if images[1]}
              <img alt={images[1].alt}  class="object-cover w-full h-full" src="/rails/active_storage/blobs/{images[1].signed_blob_id}/{images[1].filename}" />
            {/if}
            {#if images[2]}
              <img alt={images[2].alt}  class="object-cover w-full h-full" src="/rails/active_storage/blobs/{images[2].signed_blob_id}/{images[2].filename}" />
            {/if}
            {#if images[3]}
              <img alt={images[3].alt}  class="object-cover w-full h-full" src="/rails/active_storage/blobs/{images[3].signed_blob_id}/{images[3].filename}" />
            {/if}
            {#if images[4]}
              <img alt={images[4].alt}  class="object-cover w-full h-full" src="/rails/active_storage/blobs/{images[4].signed_blob_id}/{images[4].filename}" />
            {/if}
            {#if images[5]}
              <img alt={images[5].alt}  class="object-cover w-full h-full" src="/rails/active_storage/blobs/{images[5].signed_blob_id}/{images[5].filename}" />
            {/if}
          </div>
      </section>
    {:else}
      <section relative mb-20 class:odd={i % 2 == 1}>
        <h1>{title}</h1>
        <div class="md:flex gap-4" class:flex-row-reverse={i % 2 == 1}>
          {#if images?.length}
            <div class="flex-1">
              <div class="overflow-hidden w-full aspect-square relative">
                <Cycler let:current>
                  {#each images as img, j}
                    <a href="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" class="glightbox" data-gallery="section-{i}">
                      <img alt={img.alt} class:active={current == j} class="w-full absolute cycle_image" src="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" />
                    </a>
                  {/each}
                </Cycler>
              </div>
            </div>
          {/if}
          {#if text?.length}
            <div class="flex-1 lg:text-size-xl leading-6.5 spina nice">
              {@html text}
            </div>
          {/if}
        </div>
      </section>
    {/if}
  {:else}
    <section>
      Under construction :)
    </section>
  {/each}
</main>


<style>
.nice {
  line-height: 1.8rem;
  font-weight: 100;
}
h1 {
  font-size: 2rem;
}
section {

}
section h1 {
  text-align: center;
  letter-spacing: 0.3em;
  margin-bottom: 3rem;
  font-size: 2rem;
}

.title {
  left: 0;
  bottom: -20px;
  width: 100%;
  display: inline-block;    
  border-radius: 8px;
  text-align: center;
  position: absolute;      
  width: auto;
  left: 50%;
  padding: 24px 70px;
  transform: translateX(-50%);
  /* box-shadow: 0px 0px 20px rgba(0,0,0,0.2); */
  width: 700px;
  max-width: 100%;
}
.tagline2 {
  text-align: center;
}
main {
  /* padding-top: 110px; */
}


h2 {
  margin-top: 1rem;
}
.cycle_image {
    opacity: 0;
    transition: opacity 2s ease-in-out;
  }
  .cycle_image.active {
    opacity: 1;
  }
</style>