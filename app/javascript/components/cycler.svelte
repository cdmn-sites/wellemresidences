<script>
import { onMount } from "svelte";

let el
let current = 0
let children = []

function next() {
  // for (let i = 0; i < children.length; i++) {
    //   children[i].classList.remove('active')
    // }
    // children[current].classList.add('active')
    
    current = current + 1
    if (current >= children.length) current = 0
}

onMount(function() {
  children = el.children
  setInterval(next, 7000)
})

</script>

<div class="cycler" bind:this={el}>
  <slot {current} />
</div>

<style>
.cycler {
  display: contents;
}

</style>