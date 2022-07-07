<script>
import { onMount } from 'svelte';

  import ibe from '~/lib/ibe'

  onMount(function() {
    ibe.go()
  })
</script>


  <div class="ibe min-h-500px" data-widget="embed">

  </div>

<style>
  :global(iframe) {
    width: 100% !important;
    max-width: 100% !important;
  }
</style>