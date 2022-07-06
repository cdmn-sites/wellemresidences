<script>
  import store from '~/lib/store'
  export let room_type
  function max_people(room_type) {
    return (~~room_type.amenities.queen_size_bed * 2) +( ~~room_type.amenities.single_bed) + (~~room_type.amenities.sofa_bed) + (~~room_type.amenities.king_size_bed * 2)
  }
</script>
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

  

  <div class="amenity ml-7 mr-7">
    <span class="i-simple-line-icons:size-fullscreen mr-1"></span> 
    <span class="text-size-17px relative top-1px">
      {room_type.qm || '0'}m<sup text-xs>2</sup>
    </span>
  </div>
  {#if room_type.amenities.rooms}
    <div class="amenity text-size-17px">
      {room_type.amenities.rooms} {$store.t('rooms')}
      {#if room_type.amenities.terraces}
        {$store.t('+ terrace')}
      {/if}
      {#if room_type.amenities.balconies}
        {$store.t('+ balcony')}
      {/if}
    </div>
  {/if}
</div>

<style>
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
</style>