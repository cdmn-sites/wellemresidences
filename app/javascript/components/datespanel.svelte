<script>
  import DatePicker from '~/components/datepicker.svelte'
  import { slide } from 'svelte/transition'
  import store from '~/lib/store'

  let showDatepickers
  let today = new Date()
  let checkin = new Date(today)
  checkin.setDate(checkin.getDate() + 7)
  let checkout = new Date(checkin)
  checkout.setDate(checkout.getDate() + 28)
  let selectIndex = 0
  function formatDate(value, format='date') {
    if (!value) return ''
    if (typeof value != 'object') value = new Date(value);
    let options = {weekday: 'short', month: 'short', day: '2-digit', hour: 'numeric', minute: '2-digit'}
    if (format == 'date') options = {weekday: 'short', month: 'long', day: '2-digit'}
    if (format == 'time') options = {hour: 'numeric', minute: '2-digit'}
    return new Intl.DateTimeFormat('de', options).format(value) 
  }

  const zeroPad = (num, places) => String(num).padStart(places, '0')
  export function prevMonth() {
    month1.setMonth(month1.getMonth() - 1)
    month1 = month1
  }
  export function nextMonth() {
    month1.setMonth(month1.getMonth() + 1)
    month1 = month1
  }

  export let searchLink
  $: searchLink = checkin && checkout ? `https://direct-book.com/properties/intownresidencesdirect/?locale=${$store.locale}&items[0][adults]=${numAdults}&items[0][children]=${numChildren}&items[0][infants]=0&currency=EUR&checkInDate=${checkin.getFullYear()}-${zeroPad(checkin.getMonth()+1,2)}-${zeroPad(checkin.getDate(),2)}&checkOutDate=${checkout.getFullYear()}-${zeroPad(checkout.getMonth()+1,2)}-${zeroPad(checkout.getDate(),2)}&trackPage=yes` : `https://direct-book.com/properties/intownresidencesdirect/?locale=${$store.locale}&items[0][adults]=${numAdults}&items[0][children]=${numChildren}&items[0][infants]=0&currency=EUR&trackPage=yes`

  $: formattedDate1 = formatDate(checkin)
  $: formattedDate2 = formatDate(checkout)
  
  let month1 = new Date()
  $: month2 = new Date(new Date(month1).setMonth(month1.getMonth() + 1))
  
  let value = []
  let hoveredDay

  $: checkin = value[0]
  $: checkout = value[1]

  let numAdults = 2
  $: if (numAdults < 0) numAdults = 0

  let numChildren = 0
  $: if (numChildren < 0) numChildren = 0
  
  
</script>

<div class="booking">
  <div class="dates">
    <div class="options" on:click={() => showDatepickers = !showDatepickers}>
      <label class="!hidden !md:block">{$store.t('Checkin')} / {$store.t('Checkout')}</label>
        <div class="btn">
        {#if checkin && checkout}
          {formattedDate1} - {formattedDate2}
        {:else}
          {$store.t('Select dates')}
        {/if}
        {#if showDatepickers}
        <span class="i-gg-chevron-down"></span>
        {:else}
        <span class="i-gg-chevron-up"></span>

        {/if}
      </div>
    </div>
  </div>
  {#if showDatepickers}
    <div class="!md:hidden mobile overflow-hidden">
      <div class="nav">
        <div class="prev btn" on:click={prevMonth}>
          <span class="i-gg-chevron-left"></span>
        </div>
        <div class="next btn" on:click={nextMonth}>
          <span class="i-gg-chevron-right"></span>
        </div>
      </div>
      <div class="datepickers" transition:slide|local={{duration:300}}>
     
        <DatePicker locale={$store.locale}  bind:hoveredDay bind:selectIndex bind:calendarMonth={month1} bind:value />
    
      </div>
    </div>
  {/if}
  <div class="people">
    <div class="adults">
      <div class="options">
        <label>{$store.t('adults')}</label>
        <div class="btn" on:click={() => numAdults--}>-</div> {numAdults} <div class="btn" on:click={() => numAdults++}>+</div>
      </div>
    </div>
    <div class="kids">
      <div class="options">
        <label>{$store.t('children')}</label>
        <div class="btn" on:click={() => numChildren--}>-</div> {numChildren} <div class="btn" on:click={() => numChildren++}>+</div>
      </div>
    </div>
  </div>
  <div class="search">
    <div class="options">
      {#if checkin && checkout}
        <a href={searchLink} target="_blank" class="btn primary">{$store.t('Check Availability')}</a>
      {:else}
      <div class="btn disabled" >{$store.t('Check Availability')}</div>
      {/if}
    </div>
  </div>
  {#if showDatepickers}
    <div class="!hidden !md:block desktop overflow-hidden">
      <div class="nav">
        <div class="prev btn" on:click={prevMonth}>
          <span class="i-gg-chevron-left"></span>
        </div>
        <div class="next btn" on:click={nextMonth}>
          <span class="i-gg-chevron-right"></span>
        </div>
      </div>
      <div class="datepickers" transition:slide|local={{duration:300}}>

          <DatePicker locale={$store.locale}  bind:hoveredDay bind:selectIndex bind:calendarMonth={month1}  bind:value />

   
          <DatePicker locale={$store.locale}  bind:hoveredDay bind:selectIndex bind:calendarMonth={month2} bind:value />


      </div>
    </div>
  {/if}
</div>

<style>
  .booking > div {
    display: block;
    
  }
  
  .booking .dates .btn, .booking .search .btn {
    width: 100%;
  }
  .booking .datepickers {
    margin-top: 22px;
    display: flex;
    gap: 4rem;
    width: 100%;
    align-items: stretch;
  }
  .nav .btn { 
    position: absolute;
    z-index: 5;
  }
  .nav .next {
    right: 0px;
  }
  
  .nav {
    position: relative;
    /* top: -12px; */
  }
  
  .booking .people {
    width: 100%;
    display: flex;
    gap: 4rem;
    /* justify-content: space-evenly; */
  }
  .booking label {
    display: block;
    margin-bottom: 0.3rem;
  }
  .booking .options {
    display: block;
    margin-bottom: 12px;
  }
  @media (min-width: 768px) {
    .booking > div {
      display: inline-block;
      vertical-align: bottom;
    }
    .kids {
      margin-left: 1rem;
    }
    .booking .people {
      width: auto;
      display: inline-block;
      margin-left: 2rem;
      margin-right: 2rem;
    }
    .booking .people > div {
      display: inline-block;
      
    }
  }
  
</style>