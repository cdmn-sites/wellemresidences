<script>
  import HeroImages from "../../components/hero_images.svelte";
  import TabbedSections from "../../components/tabbed_sections.svelte";
  

  export let spina
  let tabbedSections = {}

  
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
      <HeroImages position={spina.header_position?.value || 'center'} height={200} images={spina.header_images.images}/>
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
  <TabbedSections {group} {sections} />
{/each}
</main>

<style>



h1 {
  color: #948a6b;
  margin-bottom: 0.1em;
  font-size: 1.8rem;
}
h2 {
  font-size: 1.4rem;
  margin-bottom: 3rem;
}
</style>