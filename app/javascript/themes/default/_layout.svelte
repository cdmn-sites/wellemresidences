<script>
  import { inertia, page } from '@inertiajs/inertia-svelte'
  import { Inertia } from '@inertiajs/inertia'
  import store from '~/lib/store'
  import glightbox from 'glightbox'

  export let account
  export let spina
  export let header_menu
  
  const leftMenu = header_menu.slice(0, Math.floor(header_menu.length / 2))
  const rightMenu = header_menu.slice(Math.floor(header_menu.length / 2))
  
  let menuOpen = false
  let scrollY

  $: moveLogo = Math.min(scrollY, 240)

  
  let bar


  function updateBar() {
    const activeA = document.querySelector('a.active')
    if (!bar) return
    if (!activeA) {
      bar.style.display = 'none'
      return
    }
    const rect = activeA.getBoundingClientRect()
    bar.style.left = `${rect.left}px`
    bar.style.width = `${rect.width}px`
    bar.style.display = 'block'
    menuOpen = false
  }
  Inertia.on('navigate', updateBar)
  Inertia.on('navigate', glightbox)
  
</script>

<svelte:window bind:scrollY on:resize={updateBar}/>

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

<div  class:menuOpen class="md:hidden menu_toggle" on:click={() => menuOpen = !menuOpen}>
  <div class="hamburger-icon" id="icon">
    <div class="icon-1" id="a"></div>
    <div class="icon-2" id="b"></div>
    <div class="icon-3" id="c"></div>
    <div class="clear"></div>
  </div>
</div>

<nav class="mobile text-size-xl leading-8" class:open={menuOpen}>
  <ul class="uppercase ">
    {#each header_menu as menuItem}
      <li>
        <a use:inertia class:active={$page.url == menuItem.path} href={menuItem.path}>{menuItem.label}</a>
      </li>
    {/each}
  </ul>
  <ul class=" uppercase mt-6">
    
      {#if $store.locale != 'en'}
        <li>
          <a href="/en">English</a>
        </li>
      {/if}
      {#if $store.locale != 'de'}
        <li>
          <a href="/de">Deutsch</a>
        </li>
      {/if}
      {#if $store.locale != 'es'}
        <li>
          <a href="/es">Español</a>
        </li>
      {/if}
    
  </ul>

  <div class="mt-6 address">
    <span class="i-gg-pin-alt"></span>
    {account.address}, {account.postal_code} {account.city}
  </div>
  <div class="phone">
    <span class="i-gg-phone"></span>
    <a href="tel:{account.phone}">{account.phone}</a> 
  </div>
  
</nav>

<slot />

<footer md:hidden>
  <div class="container">
    <div class="flex-1 mt-5">
      {account.name}<br>
      {account.address}<br>
      {account.postal_code} {account.city}<br>
      Tel: <a href="tel:{account.phone}">{account.phone}</a>
    </div>
  </div>
</footer>

<footer hidden md:block>
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
        Tel: <a href="tel:{account.phone}">{account.phone}</a>
      </div>
    </div>
  </div>
</footer>

<style>
  .active {
    /* border-top: 4px solid rgb(158, 132, 76); */
    /* font-weight: bold; */
  }
  .mobile .active {
    border-left: 4px solid rgb(158, 132, 76);
    padding-left: 3px; 
    font-weight: bold;
  }
  .active_bar {
    height: 3px;
    background: rgb(158, 132, 76);
    /* top: 48px; */
    box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
    top: 47px;
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
    right: 0px;
    top: 0px;
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

.icon-1, .icon-2, .icon-3 {
  position: absolute;
  left: 25%;
  top: 50%;
  width: 32px;
  height: 3px;
  background-color: black;
  transition: all 400ms cubic-bezier(.84,.06,.52,1.8);
}

.icon-1 {
  transform: translateY(-8px);
  animation-delay: 100ms;
}

.icon-3 {
  transform: translateY(8px);
  animation-delay: 250ms;
}

.hamburger-icon {
  position: absolute;
  height: 48px;
  width: 48px;
  top: 0px;
  right: 12px;
  z-index: 1000;
  cursor: pointer;
  
  transition: all 0.2s ease-in-out;
  
}
.hamburger-icon:hover {
  /* transform: scale(1.2);
  box-shadow: 0px 0px 30px rgba(0,0,0,0.1); */
}

.menuOpen .icon-1 {
  transform: rotate(40deg);
}
.menuOpen .icon-3 {
  transform: rotate(-40deg);
}
.menuOpen .icon-2 {
  opacity: 0;
}

@keyframes slideIn {
  0% {
    width: 0%;
   
    opacity: 0;
  }
  
  100% {
    width: 50%;
   
    opacity: 1;
  }
}
</style>
