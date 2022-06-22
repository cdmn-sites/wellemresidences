
<script>
  import store from '~/lib/store'
  import DatesPanel from '~/components/datespanel.svelte'
  import Paralax from '~/components/paralax.svelte'
  import HeroImages from '~/components/hero_images.svelte'
  import glightbox from 'glightbox'

  export let spina
  export let room_types

  let searchLink = `https://direct-book.com/properties/intownresidencesdirect/?locale=${$store.locale}&items[0][infants]=0&currency=EUR&trackPage=yes`
  function sleeps(room_type) {
    return (~~room_type.amenities.queen_size_bed * 2) +( ~~room_type.amenities.single_bed) + (~~room_type.amenities.sofa_bed) + (~~room_type.amenities.king_size_bed * 2)
  }
  function lightbox(room_type) {
    const gallery = glightbox({
      elements: room_type.images_prop.map(image => ({
        href: image.url,
        // title: image.title,
        // description: `<a class="btn text-center uppercase" href="${searchLink}&roomTypeId=${room_type.id}" target="_blank">
        //     ${$store.t('Check Availability')}
        //   </a>`,
        type: 'image'

      })),
    })
    gallery.open()
  }
</script>


<!-- {#if spina.header_images?.length} -->
<div class="h-400px md:h-500px lg:h-600px xl:h-650px">
  <HeroImages bottom images={spina.header_images.images} >
    <div class="absolute w-full h-full bg-black/45"></div>
    <Paralax y={-50}>
    <div class="serif text-center text-size-2.5 md:text-size-3 px-12 lg:text-size-5 taglines text-white absolute w-full flex items-center flex-col justify-center h-full">
      <h1>
        {spina.tagline1.content}
      </h1>
      <h2>{spina.tagline2.content}</h2>
    </div>
  </Paralax>
  </HeroImages>
</div>
<!-- {/if} -->

<section relative md:h-24 z-15 id="datespanel">

</section>


<section mt-8 class="bg-golden py-12">

  <div class="container">
    <div class="room_types md:grid-cols-2 2xl:grid-cols-3">
      <div class="md:pl-10 md:pr-50 md:col-span-2 md:text-size-5 text-left bg-white p-6 leading-7.5">
        <h4 uppercase class="text-golden mb-2">{spina.page_title}</h4>
        <h3 uppercase>{@html spina.welcome?.content}</h3>
        <p class="serif spina">
          {@html spina.intro?.content}
        </p>

      </div>
      {#each room_types as room_type}
        <div on:click={() => lightbox(room_type)} class="room_type flex flex-col bg-white p-6 shadow-sm">
          <div class="cursor-pointer overflow-hidden mb-6 shadow z-1 relative -m-2">
            <!-- {#each room_type.images_prop as image} -->
              <div class="placeholder image" style="background-image:url({room_type.thumbnail_url})"></div>
            <!-- {/each} -->
          </div>
          <h3 class="text-golden uppercase">
            {room_type.name}
          </h3>
          <div class="serif italic amenities relative min-h-8">
            <div class="amenity">
              <!-- <span class="i-material-symbols-person text-size-lg"></span> -->
              <span class="text-size-sm">{$store.t('sleeps')} {sleeps(room_type)}</span>
            </div>  | 
            {#each Object.entries(room_type.amenities) as [amenity, value], i}
              <div class="amenity">
                
                <!-- {#if value > 1} -->
                  <span class="text-size-sm">{value}  {$store.t(amenity)}</span>
                <!-- {:else} -->
                  <!-- <span class="text-size-sm">{$store.t(amenity)}</span> -->
                <!-- {/if} -->
              </div> {#if i < Object.entries(room_type.amenities).length -1} | {/if}
            {/each}
          </div>
          <!-- <p class="flex-1 mb-4 leading-6">
            {room_type.description || ''}
          </p> -->
          <a class="btn serif text-center uppercase" href="{searchLink}&roomTypeId={room_type.id}" target="_blank">
            {$store.t('Check Availability')}
          </a>
        </div>
      {/each}
    </div>
  </div>
</section>

<style>
  
  .bg-golden {
    background-color: #d8d6cf;
  }
  .text-golden {
    color: #948a6b;
  }

  .amenities {
    /* display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    text-align: center;
    margin: 0 0 1rem;
    align-items: center;
    gap: 5px; */
    margin-bottom: 1rem;
  }
  .amenity {
    display: inline-block;
    padding: 0 0.2rem;
    /* border-right: 1px solid black; */
    /* flex-grow: 1;
    padding: 0.5rem 4px;
    background-color: white; */

    /* border: 1px solid black; */
  }
  .amenity:first-of-type {
    padding-left: 0;
  }
  h1 {
    font-size: 2.5em;
    margin-top: 4rem;
  }
  h2 {
    font-size: 1.5em;
    margin-bottom: 7rem;
    margin-top: 1rem;
  }
  h3 {
    font-size: 1.5rem;
    margin-bottom: 0.7rem;
  }


  section {
    text-align: center;
  }
  .room_types {
    display: grid;
    /* @apply grid; */
    grid-gap: 1.2rem 0;

  }
  .room_type .image {
    /* margin: 12px; */
    transition: all 1s;
    aspect-ratio: calc(16 / 9);
  }
  .room_type {
    
    text-align: left;
  }
  .room_type:hover .image {
    transform: scale(1.1);
  }


</style>