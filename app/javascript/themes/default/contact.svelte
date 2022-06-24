<script>
  import HeroImages from "../../components/hero_images.svelte";
  import Cycler from "../../components/cycler.svelte";
  import Paralax from "../../components/paralax.svelte";
  

  export let spina
  export let account
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

  <section class="bg-gray/20 ">
    <div class="md:flex container">
      <div class="flex-1 text-size-0">
      {#if spina.map}
        <a href={spina.map_link?.content} target="_blank">
          <img alt={spina.map.alt} class="w-full" src="/rails/active_storage/blobs/{spina.map.signed_blob_id}/{spina.map.filename}" />
        </a>
      {/if}
    </div>
      <div class="flex-1 text-size-lg p-12 spina">
        <strong>{account.name}</strong><br>
        {account.address}<br>
        {account.postal_code} {account.city}<br>
        <a href={spina.map_link?.content} target="_blank">Find on Map</a><br><br>
        Tel: <a href="tel:{account.phone}">{account.phone}</a>
      </div>
    </div>
  </section>

  <section class="staffs shaded mt-16">
    <div class="container py-8">
      <div class="spina">
        {@html spina.staff_intro?.content}
      </div>
      <div class="md:grid grid-cols-2 xl:grid-cols-3 gap-24" >
      {#each spina.staff?.content || [] as staff, i}
      

        {@const overlay = staff.parts[0].content}
        {@const image = staff.parts[1]}
        {@const text = staff.parts[2].content}
        

        <div class="staff mt-12">
          <div class="image bg-light relative">
            <img alt={image.alt} class="w-full object-cover"  src="/rails/active_storage/blobs/{image.signed_blob_id}/{image.filename}" />
            <div class="absolute w-full text-center top-75% bottom-0 p-3 bg-white/75 uppercase tracking-wide">
              {overlay}
            </div>
          </div>
          <div class="spina mt-4">
            {@html text}
          </div>

        </div>  
    
      {/each}
    </div>
    </div>
  </section>

</main>

<style>

.staffs {
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

</style>