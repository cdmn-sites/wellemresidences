
<script>
  import store from '~/lib/store'
  import DatesPanel from '~/components/datespanel.svelte'
  import { Splide, SplideSlide } from '@splidejs/svelte-splide';
  import '@splidejs/svelte-splide/css';
  import Paralax from '~/components/paralax.svelte'
  import HeroImages from '~/components/hero_images.svelte'
  // import glightbox from 'glightbox'
  import {fade,fly} from 'svelte/transition'
  export let spina
  export let room_types
  let details

  let searchLink = `https://direct-book.com/properties/intownresidencesdirect/?locale=${$store.locale}&items[0][infants]=0&currency=EUR&trackPage=yes`
  function max_people(room_type) {
    return (~~room_type.amenities.queen_size_bed * 2) +( ~~room_type.amenities.single_bed) + (~~room_type.amenities.sofa_bed) + (~~room_type.amenities.king_size_bed * 2)
  }
  // function lightbox(room_type) {
  //   const gallery = glightbox({
  //     elements: room_type.images_prop.map(image => ({
  //       href: image.url,
  //       // title: image.title,
  //       // description: `<a class="btn text-center uppercase" href="${searchLink}&roomTypeId=${room_type.id}" target="_blank">
  //       //     ${$store.t('Check Availability')}
  //       //   </a>`,
  //       type: 'image'

  //     })),
  //   })
  //   gallery.open()
  // }
</script>

{#if details}
  <div class="w-full h-full fixed bg-black/80 z-20 top-0" transition:fade={{duration: 180}}></div>
  <div class="flex  items-center justify-center h-full fixed w-full top-0 z-22 " on:click|self={() => details = null}>
    <div class="z-21  bg-light md:bg-s p-4 w-full flex flex-col items-center relative" transition:fly={{y:50}}  on:click|self={() => details = null}>
    <div class="i-ep:close-bold absolute top-2 right-2 text-black text-2xl" on:click|self={() => details = null}></div>
    <Splide aria-label="My Favorite Images" options={{
      updateOnMove: true, height: 'max(400px, 50vh)', wheel: true, lazyLoad: 'sequencial', padding: '25%',
      breakpoints: {
        700: {
          padding: '0'
        }
      }
      }}>
      {#each details.images_prop as image, i}
        <SplideSlide>
          <img class="w-full object-contain splide_image h-full" data-splide-lazy={image.url}>
        </SplideSlide>
      {/each}

    </Splide>
    <div class="bg-light p-6 mt-4 max-w-1200px">
      <div class="text-golden uppercase">
        <h2 class="!mb-3 !mt-0">{details.name}</h2>
      </div>
      <p mb-4 class="serif text-lg md:text-xl">
        {details.description}
      </p>
      <a on:click|stopPropagation class="btn bg-gray/10 hover:bg-white serif w-full text-center uppercase" href="{searchLink}&roomTypeId={details.id}" target="_blank">
        {$store.t('Check Availability')}
      </a>
    </div>
  </div>
</div>
{/if}

<!-- {#if spina.header_images?.length} -->
<div class="h-400px md:h-500px lg:h-600px xl:h-650px">
  <HeroImages bottom images={spina.header_images.images} >
    <div class="absolute w-full h-full bg-black/45"></div>
    <Paralax y={-50}>
    <div class="text-center text-size-2.5 md:text-size-3 px-12 lg:text-size-5 taglines text-white absolute w-full flex items-center flex-col justify-center h-full">
      <h1 class="serif">
        {spina.tagline1.content}
      </h1>
      <h2 class="serif">{spina.tagline2.content}</h2>
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
      <div class="md:pl-10 md:pr-50 md:col-span-2 md:text-size-5 text-left bg-light p-6 leading-7.5">
        <h4 uppercase class="text-golden mb-2">{spina.page_title}</h4>
        <h3 uppercase>{@html spina.welcome?.content}</h3>
        <p class="serif spina">
          {@html spina.intro?.content}
        </p>

      </div>
      {#each room_types as room_type}
        <div on:click={() => details = room_type} class="room_type flex flex-col bg-light p-4 shadow-sm">
          <div class="cursor-pointer overflow-hidden mb-4 shadow z-1 relative">
            <!-- {#each room_type.images_prop as image} -->
              <div class="placeholder image" style="background-image:url({room_type.thumbnail_url})"></div>
            <!-- {/each} -->
          </div>
          <h3 class="text-golden uppercase">
            {room_type.name}
          </h3>
          <div class="serif italic amenities relative min-h-8 text-size-xl flex-1">
            {#if room_type.amenities.queen_size_bed}
              <div class="amenity">
                {#each Array(room_type.amenities.queen_size_bed) as _,i }
                  <span class="i-teenyicons-bed-double-outline"></span>
                {/each}
              </div>
            {/if}
            {#if room_type.amenities.king_size_bed}
              <div class="amenity">
                {#each Array(room_type.amenities.king_size_bed) as _,i }
                  <span class="i-teenyicons-bed-double-outline"></span>
                {/each}
              </div>
            {/if}
            {#if room_type.amenities.single_bed}
              <div class="amenity">
                {#each Array(room_type.amenities.single_bed) as _,i }
                  <span class="i-teenyicons-bed-single-outline"></span>
                {/each}
              </div>
            {/if}
            <div class="amenity -ml-1">
              <!-- <span class="i-material-symbols-person text-size-lg"></span> -->
              {#each Array(max_people(room_type)) as _,i}
              <span class="i-carbon-person -mr-2"></span>
              {/each}
              <!-- <span class="text-size-sm">{$store.t('max_people')} {max_people(room_type)}</span> -->
            </div>
            {#if room_type.amenities.bathtub}
              <div class="amenity ml-6">
                {#each Array(room_type.amenities.bathtub) as _,i }
                  <span class="i-teenyicons-bath-outline"></span>
                {/each}
              </div>
            {/if}
          
            
       
            <div class="amenity ml-7">
              <span class="i-simple-line-icons:size-fullscreen mr-1"></span> 
              <span class="text-size-17px relative top-1px">
                {room_type.qm || '0'}m<sup text-xs>2</sup>
              </span>
            </div>
          </div>
          <!-- <p class="flex-1 mb-4 leading-6">
            {room_type.description || ''}
          </p> -->
          <a on:click|stopPropagation class="btn bg-gray/10 hover:bg-white serif text-center uppercase" href="{searchLink}&roomTypeId={room_type.id}" target="_blank">
            {$store.t('Check Availability')}
          </a>
        </div>
      {/each}
    </div>
  </div>
</section>

<section class="container">
  <div class="md:flex spina text-left xl:text-size-4.5">
    <div class="flex-1  my-16">
      {@html spina.room_amenities?.content}
    </div>
    <div class="flex-1  my-16">
      {@html spina.bath_amenities?.content}
    </div>
  </div>

</section>

<style>
  .splide_image {
    transform: scale(0.8);
    transition: all 0.3s;
  }
  :global(.is-active > .splide_image) {
    transform: scale(1) !important;
  }
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

    white-space: nowrap;
    margin-bottom: 1rem;
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
    grid-gap: 2rem 0;

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