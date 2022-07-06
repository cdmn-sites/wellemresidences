<script>
  export let room_type
  import store from '~/lib/store'
  import Amenities from '../../components/amenities.svelte';
  import HeroImages from "../../components/hero_images.svelte";
  import glightbox from 'glightbox'
  import { onMount } from 'svelte';
  let searchLink = `https://direct-book.com/properties/intownresidencesdirect/?locale=${$store.locale}&items[0][infants]=0&currency=EUR&trackPage=yes`
  
  import gal from '~/lib/gallery'
  onMount(function() {
    new gal('gal', {
      minHeight: 300,
      margin: 5
    })
    const lightbox = glightbox({
      touchNavigation: true,
    })
  })
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

<main class="container relative">
  <a on:click|stopPropagation class="btn hidden md:inline-block absolute top-0 right-24px bg-gray/10 hover:bg-white serif text-center uppercase" href="{searchLink}&roomTypeId={room_type.id}" target="_blank">
    {$store.t('Check Availability')}
  </a>
  
  <h1 class="mb-4 text-golden">{room_type.name}</h1>
  <Amenities {room_type}></Amenities>

  <p class="mb-4 spina text-lg">{room_type.description}</p>
  <div id="gal" >
    {#each room_type.images_prop as image}
    <a href="{image.url}" class="glightbox">
      <img src={image.url} />
    </a>
    {/each}
  </div>

  

</main>

<style>
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