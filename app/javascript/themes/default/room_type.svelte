<script>
  export let room_type
  export let next_room_type
  export let prev_room_type
  import store from '~/lib/store'
  import Amenities from '../../components/amenities.svelte';
  import HeroImages from "../../components/hero_images.svelte";
  import { inertia } from '@inertiajs/inertia-svelte'
  import glightbox from 'glightbox'
  import flickity from 'flickity'
  
  import { Inertia } from '@inertiajs/inertia';
  
  function init() {
    $store.room_type = room_type.id
    const elems = document.querySelectorAll('.flickity')
    for (let i = 0; i < elems.length; i++) {
      const element = elems[i];
      new flickity(element, {
        // options
        cellAlign: 'left',
        bgLazyLoad: true,
        contain: true,
        pageDots: false
      })
      
    }
    glightbox({
      touchNavigation: true,
    })
  }
  Inertia.on('navigate', init)

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

{#if room_type.images_prop?.length}
  <div class="h-400px md:h-580px mb-20">
    {#key room_type.id}
      <HeroImages height={300} position='center' images={[room_type.images_prop[0]]}/>
    {/key}
  </div>
{:else}
  <div class="h-200px"></div>
{/if}

<svelte:head>
  <title>{room_type.name} - The Wellem Residences</title>
  <meta name="description" content="{room_type.description}">
</svelte:head>

<main class="container relative">
  <a on:click|stopPropagation class="btn hidden md:inline-block absolute top-0 right-24px bg-gray/10 hover:bg-white serif text-center uppercase" href="{$store.searchlink}&room_type={room_type.id}" use:inertia>
    {$store.t('Check Availability')}
  </a>
  <div class="mt-12">
    <a class="relative group" href="/" use:inertia>
      <span class="i-gg-chevron-left absolute right-100% text-size-1.7rem -top-0.5 text-gray/30 group-hover:text-black transition-all group-hover:right-105%"></span>
      {$store.t('All Categories')}
    </a>
  </div>
  <h1 class="mt-4 mb-4 text-golden text-size-2.4rem">{room_type.name}</h1>
  <Amenities {room_type}></Amenities>
  <p class="mb-12 mt-10 spina text-lg">{room_type.description || ''}</p>
  
  {#key room_type.id}
    <div class=" flickity overflow-hidden mb-4 z-1 relative">
      {#each room_type.thumbnails as thumbnail, index}
      {#if thumbnail.h <= thumbnail.w}
        <a on:pointermove={pointerMove} on:pointerdown={pointerDown} on:pointerup={pointerUp} on:click|capture|preventDefault={stopPropagationIfMoved} class="mr-3 w-full md:w-1/2 2xl:w-1/3 aspect-video block glightbox" href={room_type.images_prop[index].url}>
          <div class="placeholder image w-full h-full bg-center bg-no-repeat" style="background-image:url('{thumbnail.url}')"></div>
        </a>
        {/if}
      {/each}
    </div>
    {#each room_type.thumbnails as thumbnail, index}
    {#if thumbnail.h > thumbnail.w}
      <a class="hidden glightbox" href={room_type.images_prop[index].url}></a>
      {/if}
    {/each}
  {/key}

  
  <div class="flex gap-10 mt-18 flex-wrap">
    {#each ['details', 'kitchen', 'laundry', 'bathroom', 'entertainment', 'communication', 'other'] as cat}
    {#if room_type[cat]}
      <div class="type spina flex-1">
        <h2 class="uppercase !tracking-0.2 text-size-20px">{$store.t(cat)}</h2>
        {@html room_type[cat]}
      </div>
      {/if}
    {/each}

  </div>

  <div class="flex justify-between mt-18">
    
    {#if prev_room_type}
      <a class="block prev relative group left-5 md:left-0" href="/room_types/{prev_room_type.id}" use:inertia>
        <span class="i-gg-chevron-left absolute right-100% text-size-2.7rem text-gray/30 group-hover:text-black transition-all group-hover:right-105%"></span>
        {$store.t('Previous Category')}<br>
        <span class="text-golden md:text-xl">
          {prev_room_type.name}
        </span>
      </a>
    {:else}
      <div></div>
    {/if}
  
    {#if next_room_type}
      <a class="block prev relative group right-5 md:right-0 text-right" href="/room_types/{next_room_type.id}" use:inertia>
        <span class="i-gg-chevron-right absolute left-100% text-size-2.7rem text-gray/30 group-hover:text-black transition-all group-hover:left-105%"></span>
        {$store.t('Next Category')}<br>
        <span class="text-golden md:text-xl">
          {next_room_type.name}
        </span>
      </a>
    {/if}
    
  </div>


  <div class="mt-12">
    <a class="relative group" href="/"  use:inertia>
      <span class="i-gg-chevron-left absolute right-100% text-size-1.7rem -top-0.5 text-gray/30 group-hover:text-black transition-all group-hover:right-105%"></span>
      {$store.t('Back to Overview')}
    </a>
  </div>
</main>

<style>
  :global(.spina h1) {
    color: #948a6b;
  }
  .bg-golden {
    background-color: #d8d6cf;
  }
  .text-golden {
    color: #948a6b;
  }
  img {
    /* max-width: 100%; */
  }

</style>