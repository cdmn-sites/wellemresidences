<script>
  import HeroImages from "../../components/hero_images.svelte";
  import Cycler from "../../components/cycler.svelte";
  export let spina
  export let tenant
</script>

{#if spina.header_images?.length}
  {#key spina.page_title}
  
    <HeroImages height={300} images={spina.header_images.images}/>
  
  {/key}
{:else}
  <div class="h-100px"></div>
{/if}

<!-- <div class="relative">
  <div class="title" bg-light>
    <h1>{spina.page_title}</h1>
  </div>
</div> -->
  
  <main class="container">
    <div class="tagline2">

    </div>
  
  {#each spina.sections?.content || [] as section, i}
    {@const title = section.parts[0].content}
    {@const images = section.parts[1].images}
    {@const text = section.parts[2].content}
    <section relative class="spina">
      <h1>{title}</h1>

      <div class="w-full md:w-7/10 md:min-w-600px h-600px relative overflow-hidden">
        <Cycler let:current>
          {#each images as img, i}
            <img alt={img.alt} class:active={current == i} class="object-cover absolute w-full h-full cycle_image" src="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" />
          {/each}
        </Cycler>
      </div>
      <div class="w-7/10 text-size-lg">
        {@html text}
      </div>

    </section>
  {:else}
  <section>
    Under construction :)
  </section>
  {/each}
</main>


<style>
h1 {
  font-size: 2rem;
}
section {
  margin-top: 100px;
  margin-bottom: 200px;
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