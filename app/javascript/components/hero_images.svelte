<script>
  import Cycler from '~/components/cycler.svelte'
  export let images = []
  export let bottom = false
  let scrollY
</script>

<svelte:window bind:scrollY />


<div class="header_image relative h-full overflow-hidden">
  <Cycler let:current>
    {#each images as img, i}
      <img alt={img.alt} class:active={current == i} class:bottom-0={bottom} class="cycle_image w-full min-w-700px absolute left-1/2" src="/rails/active_storage/blobs/{img.signed_blob_id}/{img.filename}" style="transform: translateX(-50%) translateY({scrollY/2}px) scale({1 + scrollY/5000}) " />
    {/each}
  </Cycler>
  <div class="gradient" />
  <div class="shade"/>
  <slot />
</div>


<style>
  .cycle_image {
    opacity: 0;
    transition: opacity 2s ease-in-out;
  }
  .cycle_image.active {
    opacity: 1;
  }

  .gradient { 
    position: absolute;
    width: 100%;
    
    height: 160px;
    bottom: 0;
    background: linear-gradient(to bottom, rgba(0,0,0,0) 0%, rgba(0,0,0,0.3) 100%);
  }
  .header_image {
    width: 100%;
    /* height: 100%; */
    /* max-height: max(60vw, 400px); */
    
    background-position: bottom;
  }

  .shade {
    height: 20px;
    width: 100%;
    position: absolute;
    bottom: 0;
    background-color: rgba(255,255,255,0.5);
  }
</style>