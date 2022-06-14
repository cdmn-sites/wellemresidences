<script>
  import { inertia, page } from '@inertiajs/inertia-svelte'
  import { Inertia } from '@inertiajs/inertia'
  import store from '~/lib/store'

  export let account
  export let spina
  export let header_menu
  
  const leftMenu = header_menu.slice(0, Math.floor(header_menu.length / 2))
  const rightMenu = header_menu.slice(Math.floor(header_menu.length / 2))

  let menuOpen = false
  let scrollY

  $: moveLogo = Math.min(scrollY, 240)

  
  let bar

  Inertia.on('navigate', () => {
    const activeA = document.querySelector('a.active')
    const rect = activeA.getBoundingClientRect()
    bar.style.left = `${rect.left}px`
    bar.style.width = `${rect.width}px`
    menuOpen = false
  })
  
</script>

<svelte:window bind:scrollY />

<svelte:head>
  {#if spina.page_title}
    <title>{spina.page_title}</title>
  {/if}
</svelte:head>

<header>
  <div class="hidden md:block active_bar" bind:this={bar}></div>
  <div class="hidden md:flex desktop_menu justify-between">
    <div class="left_menu">
      {#each leftMenu as menuItem}
        <a use:inertia class:active={$page.url == menuItem.path} href={menuItem.path}>{menuItem.label}</a>
      {/each}
    </div>
    <div class="right_menu">
      {#each rightMenu as menuItem}
        <a use:inertia class:active={$page.url == menuItem.path} href={menuItem.path}>{menuItem.label}</a>
      {/each}
    </div>
  </div>
</header>

<div class="h-40px"></div>
<div class="shade"></div>
<img class="logo" src="/rails/active_storage/blobs/{spina.logo.signed_blob_id}/{spina.logo.filename}" alt={account.name} style="transform: translate(-50%, {-moveLogo/3.4}px) scale({1 - moveLogo / 500})">

<div class="md:hidden menu_toggle" on:click={() => menuOpen = !menuOpen}>
  MENU
</div>

<nav class="mobile" class:open={menuOpen}>
  <ul>
    {#each header_menu as menuItem}
      <li>
        <a use:inertia href={menuItem.path}>{menuItem.label}</a>
      </li>
    {/each}
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
    {account.address}, {account.postal_code} {account.city}
  </div>
  <div class="phone">
    <span class="i-gg-phone"></span>
    <a href="tel:{account.phone}">{account.phone}</a> 
  </div>
  
</nav>

<slot />

<footer>
  <div class="container">
    <div class="flex">
      <ul class="flex-1">
        <li>
          <a href="/en">English</a>
        </li>
        <li>
          <a href="/de">Deutsch</a>
        </li>
        <li>
          <a href="/es">Español</a>
        </li>
      </ul>
      <ul class="flex-1">
        {#each leftMenu as menuItem}
        <li>
          <a use:inertia href={menuItem.path}>{menuItem.label}</a>
        </li>
        {/each}
      </ul>
      <ul class="flex-1">
        {#each rightMenu as menuItem}
        <li>
          <a use:inertia href={menuItem.path}>{menuItem.label}</a>
        </li>
        {/each}
      </ul>
      <div class="flex-1">
        {account.name}<br>
        {account.address}<br>
        {account.postal_code} {account.city}<br>
        {account.phone}
      </div>
    </div>
  </div>
</footer>

<style>
  .active {
    /* border-top: 4px solid rgb(158, 132, 76); */
    /* font-weight: bold; */
  }
  .active_bar {
    height: 2px;
    background: #162866;
    /* top: 48px; */
    top: 0;
    position: absolute;
    transition: all 0.3s ease-in-out;
  }
  footer {
    margin-top: 100px;
  }
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
    
    background: #f9fafe88;
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
  header a {
    padding: 12px;
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
