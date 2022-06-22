<script>
  import { onMount } from 'svelte';

  export let scale = 1
  export let y = 0

  let scrollY

  let innerHeight
  let startY
  $: ratio = ((scrollY - startY + innerHeight) / innerHeight)

  let el
  onMount(function() {
    startY = el.getBoundingClientRect().top
  })
</script>

<svelte:window bind:scrollY bind:innerHeight/>

<div bind:this={el} style="transform: scale({1 + ratio * (scale-1)}) translateY({ratio * y - 2 * y}px)">
  <slot />
</div>


<style>
  div {
    position: relative;
    height: 100%;
    width: 100%;
  }
</style>