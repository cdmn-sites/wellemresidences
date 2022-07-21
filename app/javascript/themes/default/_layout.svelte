<script>
  import { inertia, page } from '@inertiajs/inertia-svelte'
  import { Inertia } from '@inertiajs/inertia'
  
  import DatesPanel from '../../components/datespanel.svelte';
  import store from '~/lib/store'
  import glightbox from 'glightbox'
  import { fade,slide } from 'svelte/transition'
  export let hidelayout

  export let account
  export let spina
  export let header_menu
  export let footer_menu
  export let locale_paths = {}

  let showDatepickers
  
  const leftMenu = header_menu.slice(0, Math.floor(header_menu.length / 2))
  const rightMenu = header_menu.slice(Math.floor(header_menu.length / 2))
  
  let menuOpen = false
  let scrollY

  $: moveLogo = Math.min(scrollY, 240)
  let changeLangOpen = false
  
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
  }
  setInterval(updateBar, 1000)
  Inertia.on('navigate', function() {
    updateBar()
    menuOpen = false
    glightbox()
  })
  
  
  let placed
  let datespanel
  Inertia.on('navigate', function() {
    const target = document.getElementById('datespanel')
    if (target) {
      target.appendChild(datespanel)
      placed = true
    }
    else if (datespanel) {
      document.body.appendChild(datespanel)
      placed = false
    }
  })

</script>

<svelte:window bind:scrollY on:resize={updateBar}/>

<svelte:head>
  {#if spina.page_title}
    <title>{spina.page_title}</title>
  {/if}
</svelte:head>


{#if showDatepickers}
<div transition:fade={{duration: 150}} class="md:hidden fixed w-full h-screen top-0 left-0 bg-black/30 z-15" on:click={() => showDatepickers = false}/>
{/if}

<div class="datespanel z-15 md:z-5" bg-light class:placed bind:this={datespanel} class:!hidden={hidelayout} >
  <!-- <div id="avantio-form" class="horizontal"></div>{@html avantioHtml}     -->
  <DatesPanel bind:showDatepickers/>
</div>

{#if hidelayout}
<a href="/{$store.locale}" use:inertia class="logo shadow-lg p-4.5 !z-9" style="transform: translate(-50%, -70px) scale(0.5)">
  <img class="w-full" src="/images/{spina.logo.signed_blob_id}/{spina.logo.filename}" alt={account.name}>
</a>
{:else}
<a href="/{$store.locale}" use:inertia class="hidden shadow-lg md:block logo !p-4.5 !z-9" style="transform: translate(-50%, {-(moveLogo)/4.2 -8 }px) scale({1 - moveLogo / 500})">
  <img class="w-full" src="/images/{spina.logo.signed_blob_id}/{spina.logo.filename}" alt={account.name}>
</a>
<a href="/{$store.locale}" use:inertia class="md:hidden shadow-lg logo !p-4.5 !z-9" style="transform: translate(-50%, {-(moveLogo)/6  }px) scale({1 - moveLogo / 400})">
  <img class="w-full" src="/images/{spina.logo.signed_blob_id}/{spina.logo.filename}" alt={account.name}>
</a>
{/if}

<header shadow>
  {#if hidelayout}
    <a href="/{$store.locale}" use:inertia class="logo p-4.5" style="transform: translate(-50%, -70px) scale(0.5)">
      <img class="w-full" src="/images/{spina.logo.signed_blob_id}/{spina.logo.filename}" alt={account.name}>
    </a>
  {:else}
    <a href="/{$store.locale}" use:inertia class="hidden md:block logo !p-4.5" style="transform: translate(-50%, {-(moveLogo)/4.2 -8 }px) scale({1 - moveLogo / 500})">
      <img class="w-full" src="/images/{spina.logo.signed_blob_id}/{spina.logo.filename}" alt={account.name}>
    </a>
    <a href="/{$store.locale}" use:inertia class="md:hidden logo !p-4.5" style="transform: translate(-50%, {-(moveLogo)/6  }px) scale({1 - moveLogo / 400})">
      <img class="w-full" src="/images/{spina.logo.signed_blob_id}/{spina.logo.filename}" alt={account.name}>
    </a>
  {/if}
  <div class="tel fixed z-20 top-10px left-0">
    <a href="/{$store.locale}" use:inertia>
      <img class="align-middle h-34px relative -top-2px" src="/images/{spina.favicon.signed_blob_id}/{spina.favicon.filename}" alt={account.name}>
    </a>
    {#if !hidelayout}
      <span class="ml-2 cursor-pointer uppercase" on:click={() => changeLangOpen = !changeLangOpen}>
        {$store.locale}
      </span>
    {/if}
    {#if changeLangOpen}
      <div class="change_lang fixed ml-8 bg-light p-4 uppercase shadow" transition:slide={{duration: 100}}>
        {#if $store.locale != 'en'}
       
          <a class="block " href={locale_paths?.en || '?locale=en'}>English</a>
        
      {/if}
      {#if $store.locale != 'de'}
     
          <a class="block " href={locale_paths?.de || '?locale=de'}>Deutsch</a>
       
      {/if}
      {#if $store.locale != 'es'}
 
          <a class="block " href={locale_paths?.es || '?locale=es'}>Español</a>
     
      {/if}
    </div>
    {/if}
    <span class="i-gg-phone relative text-xl -top-2px ml-20px -mr-10px"></span>
    <a href="tel:{account.phone}">{account.phone}</a> 
  </div>
  <div class="hidden lg:block active_bar" bind:this={bar}></div>
  <div class="hidden lg:flex desktop_menu justify-between pr-12 2xl:pr-0 z-15 relative">
    <div class="left_menu uppercase">
    </div>
    <div class="right_menu uppercase">
      <div class="hidden 2xl:inline-block">
        {#each leftMenu as menuItem}
          <a use:inertia class:active={$page.url == menuItem.path} href={menuItem.path}>{menuItem.label}</a>
        {/each}
        {#each rightMenu as menuItem}
          <a use:inertia class:active={$page.url == menuItem.path} href={menuItem.path}>{menuItem.label}</a>
        {/each}
      </div>
    </div>
  </div>
</header>

<div class="h-38px"></div>
<div class="shade"></div>

<div class:menuOpen class="2xl:hidden menu_toggle" on:click={() => menuOpen = !menuOpen}>
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
  <ul class="uppercase mt-6">
    
    {#if $store.locale != 'en'}
      <li>
        <a href={locale_paths?.en || '?locale=en'}>English</a>
      </li>
    {/if}
    {#if $store.locale != 'de'}
      <li>
        <a href={locale_paths?.de || '?locale=de'}>Deutsch</a>
      </li>
    {/if}
    {#if $store.locale != 'es'}
      <li>
        <a href={locale_paths?.es || '?locale=es'}>Español</a>
      </li>
    {/if}
    
  </ul>

  <div class="mt-6 address">
    <span class="i-gg-pin-alt"></span>
    <a href="https://www.google.com/maps/place/{account.address} {account.postal_code} {account.city}" target="_blank">
      {account.address}, {account.postal_code} {account.city}
    </a>
  </div>
  <div class="phone">
    <span class="i-gg-phone"></span>
    <a href="tel:{account.phone}">{account.phone}</a> 
  </div>
  
</nav>

<slot />


{#if spina.footer_text?.content}
 <div class="bottom mt-24 relative bg-cover bg-top" style="background-image:url('/images/{spina.footer_image?.signed_blob_id}')">
    <div class="absolute w-full h-full bg-black/75 top-0 right-0"></div>
    <div class="relative serif text-center text-white spina mt-8 pt-20 pb-26">
      {@html spina.footer_text?.content}
    </div>
  </div>
{:else}
<div class="mt-24"></div>
{/if}
  
<footer class="bottom relative bg-cover bg-top">


  <!-- <div class="md:hidden relative container">
    <div class="flex-1 mt-5">
      <a href="https://www.google.com/maps/place/{account.address} {account.postal_code} {account.city}" target="_blank">
        {account.name}<br>
        {account.address}<br>
        {account.postal_code} {account.city}
      </a><br>
      Tel: <a href="tel:{account.phone}">{account.phone}</a>
    </div>
  </div> -->
  <div class="relative container mt-4 serif">
    <div class="md:flex">
      <div class="flex-1 mb-5">
        <h4 mb-4 uppercase>
          {$store.t('CONTACT US')}
        </h4>
        {account.name}<br>
        {account.address}<br>
        {account.postal_code} {account.city}<br>
        <a href="https://www.google.com/maps/place/{account.address} {account.postal_code} {account.city}" target="_blank">Find on Map</a><br>
        Tel: <a href="tel:{account.phone}">{account.phone}</a>
      </div>
      <div class="flex-1 mb-5">
        <h4 mb-4 uppercase>
          {$store.t('INFORMATION')}
        </h4>
        {#each leftMenu as menuItem}
        
          <a use:inertia href={menuItem.path}>{menuItem.label}</a><br>
        
        {/each}
        {#each rightMenu as menuItem}
        
          <a use:inertia href={menuItem.path}>{menuItem.label}</a><br>
        
        {/each}
      </div>
      <div class="flex-1 mb-5">
        <h4 mb-4 uppercase>
          {$store.t('Partners')}
        </h4>
        {@html spina.partner_links?.content}
      </div>
      <div class="flex-1 mb-5">
        <h4 mb-4 uppercase>
          {$store.t('LANGUAGE')}
        </h4>
        
          <a href="/en">English</a><br>
        
        
          <a href="/de">Deutsch</a><br>
        
        
          <a href="/es">Español</a>
        
      </div>
    </div>
  </div>
  <div class="container relative">
  <div class="copyright absolute right-4 text-sm text-right">
    &copy; 2022 InTown Hospitality GmbH <br>
    {#each footer_menu as menuItem}
    
      <a use:inertia href={menuItem.path}>{menuItem.label}</a>
    
    {/each}
  </div>
</div>


</footer>
  



<style>
  .active {
    /* border-top: 4px solid rgb(158, 132, 76); */
    /* font-weight: bold; */
  }
  :global(body) {
  overflow-x: hidden;
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
    top: 40px;
    z-index: 15;
    position: absolute;
    transition: all 0.3s ease-in-out;
  }
  footer {

    padding-bottom: 180px;
    background-color: rgb(119, 118, 115);
    color: white;
    line-height: 1.6rem;
    font-size: 18px;
  }
  nav.mobile {
    position: fixed;
    width: 100%;
    height: 100%;
    background: #f9fafe;
    z-index: 15;
    left: 100%;
    top: 0;
    transition: all 0.3s;
    padding: 32px;
    padding-top: 64px;
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
.change_lang a {
  border-left: 3px solid transparent;
}
.change_lang a:hover {
  border-left: 3px solid rgb(158, 132, 76);
}
.datespanel {
    position: fixed;
    left: 0;
    bottom: 0;
    width: 100%;
    display: inline-block;    
    /* border-radius: 8px; */
    padding: 13px 20px 3px;
    text-align: center;
    text-transform: uppercase;
    box-shadow: 0px -4px 20px rgba(0, 0, 0, 0.35);
  }
  @media (min-width: 768px) {
    .datespanel.placed {
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
