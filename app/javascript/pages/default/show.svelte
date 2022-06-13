<script>
  import HeroImages from "../../components/hero_images.svelte";
  import Cycler from "../../components/cycler.svelte";
  import Paralax from "../../components/paralax.svelte";
  export let spina
  export let tenant
</script>

{#if spina.header_images.images?.length}
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

  {#if style == 'plain'}
    <section relative mb-20 class:odd={i % 2 == 1}>
      <h1>{title}</h1>
      <div class="md:flex gap-4" class:flex-row-reverse={i % 2 == 1}>
        {#if images?.length}
          <div class="flex-1">
            <Cycler let:current>
              {#each images as img, i}
                <img alt={img.alt} class:active={current == i} class="w-full cycle_image" src="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" />
              {/each}
            </Cycler>
          </div>
        {/if}
        {#if text?.length}
          <div class="flex-1">
            {@html text}
          </div>
        {/if}
      </div>
    </section>
  {:else}
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