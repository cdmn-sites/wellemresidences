<script>
  import HeroImages from "../../components/hero_images.svelte";
  import Cycler from "../../components/cycler.svelte";
  import Paralax from "../../components/paralax.svelte";
  

  export let spina
  let tabbedSections = {}
  let selectedTabs = {
    top: 0,
    middle: 0,
    bottom: 0
  }
  $: if (spina.sections?.content) {
    tabbedSections = {}
    for (let i = 0; i < spina.sections.content.length; i++) {
      const section = spina.sections.content[i]
      const group = section.parts[4]?.value || 'top'
      tabbedSections[group] ||= []
      tabbedSections[group].push(section)
    }
  }
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

  
<main>
  <section class="container">
    <h1 uppercase>
      {spina.tagline1.content}
    </h1>
    <h2 uppercase>
      {spina.tagline2.content}
    </h2>
  </section>
  
{#each Object.entries(tabbedSections) as [group, sections]}
  {#if sections.length > 1}
    <div class="container">
      <div class="tabbar uppercase">
        {#each sections as section, i}
          <div class="tab inline-block text-gray" class:active={selectedTabs[group] == i} on:click={() => selectedTabs[group] = i}>
            {section.parts[0].content}
          </div>
        {/each}
      </div>
    </div>
  {/if}

  {#each sections as section, i}
    {@const title = section.parts[0].content}
    {@const images = section.parts[1].images}
    {@const text = section.parts[2].content}
    {@const style = section.parts[3]?.value}
    {@const color = section.parts[5]?.value}
    <div class:!block={selectedTabs[group] == i} class="hidden" >

      {#if style == 'parallax'}
        <section relative class:odd={i % 2 == 1} class="container spina mb-20 lg:h-140 xl:h-180">
          {#if title}
            <h3 class="uppercase mb-3 text-size-1.5rem md:text-size-1.8rem">{title}</h3>
          {/if}
          {#if images?.length}
            <div class:right-0={i % 2 == 1} class="relative lg:absolute aspect-video lg:w-7/10  overflow-hidden">
              <!-- <Paralax scale={1.05} y={120}> -->
                <Cycler let:current>
                  {#each images as img, i}
                  
                    <img alt={img.alt} class:active={current == i} class="lg:absolute object-cover w-full h-full cycle_image" src="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" />
                  
                  {/each}
                </Cycler>
              <!-- </Paralax> -->
            </div>
          {/if}
          <Paralax y={-100}>
            <div class:right-0={i % 2 == 0} class="serif relative -top-70px lg:text-size-lg xl:text-size-xl xl:w-12/10 lg:max-w-500px xl:max-w-700px shadow-2xl bg-light/90 p-6 lg:absolute lg:top-140px xl:top-300px">
              {@html text}
            </div>
          </Paralax>
        </section>
      {:else if style == 'mosaic'}
        <section mb-28 class="container">
          {#if title}
            <h3 class="uppercase mb-5 text-size-1.5rem md:text-size-1.8rem">{title}</h3>
          {/if}
          <div class="md:grid gap-4 grid-cols-2 xl:grid-cols-3">
            {#if images[0]}
              <img alt={images[0].alt} data-gallery="section{i}"  class="glightbox object-cover w-full h-full" src="/rails/active_storage/blobs/{images[0].signed_blob_id}/{images[0].filename}" />
            {/if}
            {#if text}
            <div class="spina serif md:bg-white md:shadow py-5 md:p-5 text-justify  leading-6 tracking-wide lg:text-size-4.5 2xl:text-size-lg 2xl:leading-7">
              {@html text}
            </div>
            {/if}
            {#if images[1]}
              <img alt={images[1].alt} data-gallery="section{i}"  class="glightbox object-cover w-full h-full" src="/rails/active_storage/blobs/{images[1].signed_blob_id}/{images[1].filename}" />
            {/if}
            {#if images[2]}
              <img alt={images[2].alt} data-gallery="section{i}"  class="glightbox hidden md:block object-cover w-full h-full" src="/rails/active_storage/blobs/{images[2].signed_blob_id}/{images[2].filename}" />
            {/if}
            {#if images[3]}
              <img alt={images[3].alt} data-gallery="section{i}"  class="glightbox hidden md:block object-cover w-full h-full" src="/rails/active_storage/blobs/{images[3].signed_blob_id}/{images[3].filename}" />
            {/if}
            {#if images[4]}
              <img alt={images[4].alt} data-gallery="section{i}"  class="glightbox hidden md:block object-cover w-full h-full" src="/rails/active_storage/blobs/{images[4].signed_blob_id}/{images[4].filename}" />
            {/if}
            {#if images[5]}
              <img alt={images[5].alt} data-gallery="section{i}"  class="glightbox hidden md:block object-cover w-full h-full" src="/rails/active_storage/blobs/{images[5].signed_blob_id}/{images[5].filename}" />
            {/if}
          </div>
        </section>
      {:else}
        <section class:shaded={color == 'shaded'} relative mb-5 md:mb-15 class:odd={i % 2 == 1}>
          <div class="container gap-8 md:flex" class:flex-row-reverse={i % 2 == 1}>
            {#if images?.length > 1}
              <div class="flex-1">
                <div class="overflow-hidden aspect-video w-full text-size-0 relative">
                  <Cycler let:current>
                    {#each images as img, j}
                      <a href="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" class="glightbox" data-gallery="section-{i}">
                        <img alt={img.alt} class:active={current == j} class="w-full absolute cycle_image" src="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" />
                      </a>
                    {/each}
                  </Cycler>
                </div>
              </div>
            {:else if images?.length == 1}
              <div class="flex-1">
                <div class="overflow-hidden w-full text-size-0 relative">
                  {#each images as img, j}
                    <a href="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" class="glightbox" data-gallery="section-{i}">
                      <img alt={img.alt} class="w-full active cycle_image" src="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" />
                    </a>
                  {/each}
                
                </div>
              </div>
            
            {/if}
            {#if text?.length}
              <div class="flex-1  xl:text-size-xl leading-6 xl:leading-7 spina py-6">
                {#if title}
                  <h3 class="uppercase mb-5 text-size-1.5rem md:text-size-1.8rem">{title}</h3>
                {/if}
                <div class="serif font-100">
                  {@html text}
                </div>
              </div>
            {/if}
          </div>
        </section>
      {/if}
    </div>
  {/each}
{/each}
</main>

<style>


.tabbar {
  border-bottom: 1px solid #ccc;
  margin-bottom: 24px;
}
.tab {
  padding: 12px;
  cursor: pointer;
}
.tab.active {
  color: black;
  margin-bottom: -1px;
  border-bottom: 1px solid black;
}
.tab:first-child {
  padding-left: 0px;
}
section.shaded {
  background-color: #d8d6cf;
}
h1 {
  color: #948a6b;
  margin-bottom: 0.1em;
  font-size: 1.8rem;
}
h2 {
  font-size: 1.4rem;
  margin-bottom: 3rem;
}
section h3 {
  color: #948a6b;
  letter-spacing: 0.1em;
}

.cycle_image {
    opacity: 0;
    transition: opacity 2s ease-in-out;
  }
  .cycle_image.active {
    opacity: 1;
  }
</style>