
<script>
  import store from '~/lib/store'

  import Paralax from '~/components/paralax.svelte'
  import HeroImages from '~/components/hero_images.svelte'
  import Amenities from '../../components/amenities.svelte';
  import { inertia } from '@inertiajs/inertia-svelte'
  import glightbox from 'glightbox'
  import {fade,fly} from 'svelte/transition'
  export let spina
  export let room_types
  import flickity from 'flickity'

  import { onMount } from 'svelte';

  let details
  
  onMount(function() {
    const elems = document.querySelectorAll('.flickity')
    for (let i = 0; i < elems.length; i++) {
      const element = elems[i];
      new flickity(element, {
        // options
        cellAlign: 'left',
        bgLazyLoad: true,
        contain: true
      })
      
    }
    glightbox()
  })

  let down = false
  let moved = false
  function stopPropagationIfMoved(ev) {
    if (moved) ev.stopPropagation()
  }
  function pointerDown() {
    down = true
    moved = false
  }
  function pointerUp() {
    setTimeout(function() {
      down = false
      moved = false

    }, 10)
  }
  function pointerMove() {
    if (down) moved = true
  }
</script>

<!-- {#if details}
  <div class="w-full h-full fixed bg-black/80 z-20 top-0" transition:fade={{duration: 180}}></div>
  <div class="flex items-center justify-center h-full fixed w-full top-0 z-22" on:click|self={() => details = null}>
    <div class="z-21 p-4 w-full flex h-screen flex-col items-center relative" transition:fly={{y:50}} on:click|self={() => details = null}>
    <div class="i-ep-close cursor-pointer absolute z-21 top-2 right-2 text-white text-size-10" on:click|self={() => details = null}></div>
    <div class="flex-1 flex items-center w-screen">
      <Splide aria-label="My Favorite Images" options={{
        updateOnMove: true, width: '100%', height: '100%', wheel: true, lazyLoad: 'sequencial', padding: '20%',
        breakpoints: {
          1000: {
            padding: '0'
          },
          1300: {
            padding: '10%'
          }
        }
        }}>
        {#each details.images_prop as image, i}
          <SplideSlide>
            <img on:click={() => lightbox(image.url)} class="w-full object-contain splide_image h-40vh md:h-70vh" data-splide-lazy={image.url}>
          </SplideSlide>
        {/each}

      </Splide>
    </div>
    <div class="bg-light p-6 mt-4 max-w-1200px">
      <div class="text-golden uppercase">
        <h2 class="!mb-3 !mt-0">{details.name}</h2>
      </div>
      <p mb-4 class="serif leading-5 md:text-xl">
        {details.description}
      </p>
      <a on:click|stopPropagation class="btn bg-gray/10 hover:bg-white serif w-full text-center uppercase" href="{searchLink}&roomTypeId={details.id}" target="_blank">
        {$store.t('Check Availability')}
      </a>
    </div>
  </div>
</div>
{/if} -->

<!-- {#if spina.header_images?.length} -->
<div class="h-400px md:h-500px lg:h-600px xl:h-650px">
  <HeroImages position="bottom" images={spina.header_images.images} >
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


<section class="bg-golden py-12 md:mt-8">

  <div class="container">
    <div class="room_types md:grid-cols-2 2xl:grid-cols-3">
      <div class="md:pl-10 md:pr-50 md:col-span-2 md:text-size-5 text-left bg-light p-6 leading-7.5">
        <h4 uppercase class="text-golden mb-2">{spina.page_title}</h4>
        <h3 uppercase>{@html spina.welcome?.content}</h3>
        <p class="serif spina text-justify">
          {@html spina.intro?.content}
        </p>

      </div>
      {#each room_types as room_type}
        <div  class="room_type flex flex-col bg-light p-4 shadow-sm">
        <!-- <div class="room_type flex flex-col bg-light p-4 shadow-sm"> -->
          <div class=" flickity aspect-video overflow-hidden mb-4 shadow z-1 relative">
            {#each room_type.thumbnails as thumbnail, index}
            <a on:pointermove={pointerMove} on:pointerdown={pointerDown} on:pointerup={pointerUp} on:click|capture|preventDefault={stopPropagationIfMoved} class="w-full h-full glightbox" href={room_type.images_prop[index].url}>
              <div class="placeholder image w-full h-full bg-center bg-no-repeat" data-flickity-bg-lazyload={thumbnail.url}></div>
            </a>
            {/each}
          </div>
          <h3 class="text-golden uppercase">
            {room_type.name}
          </h3>
          <Amenities {room_type}></Amenities>
          <a class="mb-6 mt-2  text-lg underline " href="/room_types/{room_type.id}" use:inertia>{$store.t('More information')}</a>
          <!-- <p class="flex-1 mb-4 leading-6">
            {room_type.description || ''}
          </p> -->
        
        <a on:click|stopPropagation class="btn bg-gray/10 hover:bg-white serif text-center uppercase" href="{$store.searchlink}&room_type={room_type.id}" target="_blank">
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
  .bg-golden {
    background-color: #d8d6cf;
  }
  .text-golden {
    color: #948a6b;
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
  .room_type .image:hover  {
    transform: scale(1.1);
  }


</style>