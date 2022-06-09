<script>
  export let tenant
  export let spina
  
  import store from '~/lib/store'

  let menuOpen = false
  let scrollY
  $: moveLogo = Math.min(scrollY, 240)
</script>

<svelte:window bind:scrollY />

<svelte:head>
  {#if spina.page_title}
    <title>{spina.page_title}</title>
  {/if}
</svelte:head>

<header>
  <div class="hidden md:block desktop_menu">
    Desktop Menu here
  </div>
</header>

<div class="shade"></div>
<img class="logo" src="/rails/active_storage/blobs/{spina.logo.signed_blob_id}/{spina.logo.filename}" alt={tenant.name} style="transform: translate(-50%, {-moveLogo/3.4}px) scale({1 - moveLogo / 500})">

<div class="md:hidden menu_toggle" on:click={() => menuOpen = !menuOpen}>
  HAMBURGER
</div>

<nav class="mobile" class:open={menuOpen}>
  <ul>
    <li>
      <a href="/">About us</a>
    </li>
    <li>
      <a href="/">Residences</a>
    </li>
    <li>
      <a href="/">Culinary</a>
    </li>
    <li>
      <a href="/">Events</a>
    </li>
    <li>
      <a href="/">Contact</a>
    </li>
    <li>
      <a href="/">FAQ</a>
    </li>
  </ul>
  <div class="locale uppercase with-popup">
    {$store.locale}
    <div class="popup">
      <a href="/en" sveltekit:reload>English</a>
      <a href="/de" sveltekit:reload>Deutsch</a>
    </div>
  </div>

  <div class="address">
    <span class="i-gg-pin-alt"></span>
    {tenant.address}, {tenant.postal_code} {tenant.city}
  </div>
  <div class="phone">
    <span class="i-gg-phone"></span>
    <a href="tel:{tenant.phone}">{tenant.phone}</a> 
  </div>
  
</nav>

<slot />

<footer>
  <div class="container">
    {tenant.name}<br>
    {tenant.address}<br>
    {tenant.postal_code} {tenant.city}<br>
    {tenant.phone}
  </div>
</footer>

<style>
  nav.mobile {
    position: fixed;
    width: 100%;
    height: 100%;
    background: #f9fafe;
    z-index: 15;
    left: 100%;
    transition: all 0.3s;
    padding: 16px;
  }
  nav.mobile.open {
    left: 0;
  }
  .menu_toggle {
    position: fixed;
    z-index: 16;
    right: 16px;
    top: 16px;
  }
  .shade {
    height: 20px;
    width: 100%;
    position: fixed;
    
    top: 50px;
    z-index: 1;
    background: rgba(255, 255, 255, 0.5);
  }
  .with-popup {
    position: relative;
    cursor: pointer;
  }
  .with-popup .popup {
    display: none;
  }
  .popup a {
    display: block;
    padding: 10px;
    text-decoration: none;
  }
  .with-popup:hover .popup {
    display: block;
    position: absolute;
    top: 100%;
    right: 0;
    z-index: 100;
    background: #fff;
    padding: 10px;
    border-radius: 5px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
  }
  .locale {
    margin-left: 14px;
  }

  header {
    
    height: 50px;
    padding: 15px;
    position: fixed;
    z-index: 10;
    width: 100%;
    background-color: #f9fafe;
  }

  .logo {
    background: #f9fafe;
    position: fixed;
    width: 300px;
    left: 50%;
    top: 40px;
    z-index: 14;
    transform: translate(-50%, 0);
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
  }
  @media (min-width: 1167px) {

  }
</style>
