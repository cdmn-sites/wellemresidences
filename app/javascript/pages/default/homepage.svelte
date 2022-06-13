
<script>
  import store from '~/lib/store'
  import DatesPanel from '~/components/datespanel.svelte'
  import HeroImages from '~/components/hero_images.svelte'
  export let tenant
  export let spina
  export let room_types

  let searchLink = `https://direct-book.com/properties/intownresidencesdirect/?locale=${$store.locale}&items[0][infants]=0&currency=EUR&trackPage=yes`
  function sleeps(category) {
    return (~~category.amenities.queen_size_bed * 2) +( ~~category.amenities.single_bed) + (~~category.amenities.sofa_bed) + (~~category.amenities.king_size_bed * 2)
  }
</script>


<HeroImages bottom images={spina.header_images.images} />


<section relative md:h-24>
  <div class="datespanel" bg-light>
    <!-- <div id="avantio-form" class="horizontal"></div>{@html avantioHtml}     -->
    <DatesPanel bind:searchLink/>
  </div>
</section>


<section>
  <h1 class="tagline">
    {spina.tagline1.content}
  </h1>
  <h2>{spina.tagline2.content}</h2>
  <div class="grid grid-cols-4 grid-flow-col w-full gap-4 auto-cols-fr">

  </div>

  <div class="container">
    <div class="room_types md:grid-cols-2 2xl:grid-cols-3">
      {#each room_types as category}
        <div class="category flex mb-8 flex-col bg-white p-6 shadow-sm">
          <div class="overflow-hidden mb-6 shadow-md z-1 relative -m-6">
            <div class="placeholder image" style="background-image:url({category.image_url})"></div>
          </div>
          <h3 class="name">
            {category.name}
          </h3>
          <div class="amenities relative min-h-10">
            <div class="amenity">
              <!-- <span class="i-material-symbols-person text-size-lg"></span> -->
              <span class="text-size-sm">{$store.t('sleeps')} {sleeps(category)}</span>
            </div>  | 
            {#each Object.entries(category.amenities) as [amenity, value], i}
              <div class="amenity">
                
                <!-- {#if value > 1} -->
                  <span class="text-size-sm">{value}  {$store.t(amenity)}</span>
                <!-- {:else} -->
                  <!-- <span class="text-size-sm">{$store.t(amenity)}</span> -->
                <!-- {/if} -->
              </div> {#if i < Object.entries(category.amenities).length -1} | {/if}
            {/each}
          </div>
          <p class="flex-1 mb-4">
            {category.description}
          </p>
          <a class="btn text-center uppercase" href="{searchLink}&roomTypeId={category.id}" target="_blank">
            {$store.t('Check Availability')}
          </a>
        </div>
      {/each}
    </div>
  </div>
</section>

<style>

  .datespanel {
    position: fixed;
    left: 0;
    bottom: 0;
    width: 100%;
    display: inline-block;    
    border-radius: 8px;
    padding: 20px 20px 10px;
    text-align: left;
    text-transform: uppercase;
    box-shadow: 0px -4px 20px rgba(0, 0, 0, 0.35);
    z-index: 5;
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
  h1 {
    font-size: 2.5rem;
    margin-top: 4rem;
  }
  h2 {
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
    grid-gap: 1.2rem;
  }
  .category .image {
    transition: all 1s;
    aspect-ratio: calc(16 / 9);
  }
  .category {
    text-align: left;
  }
  .category:hover .image {
    transform: scale(1.1);
  }
  @media (min-width: 768px) {
    .datespanel {
      white-space: nowrap;
      position: absolute;      
      bottom: 0px;
      width: auto;
      left: 50%;
      padding: 24px 70px;
      transform: translateX(-50%);
      box-shadow: 0px 0px 20px rgba(0,0,0,0.2);
      min-width: 700px;
    }
  }

</style>