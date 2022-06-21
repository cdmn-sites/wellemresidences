<script>
  import store from '~/lib/store';
  import { useForm } from '@inertiajs/inertia-svelte'
  import { onMount } from 'svelte';
  export let spina
  const form = useForm('contact', {text: '', email: '', name: '', not_a_bot: false})
  export let flash = {}
  onMount(() => {
    setTimeout(() => {
      $form.not_a_bot = true
    }, 3000)
  })
  import HeroImages from "~/components/hero_images.svelte";
</script>

{#if spina.header_images?.images?.length}
  <div class="h-300px md:h-430px mb-20">
    {#key spina.page_title}
      <HeroImages height={200} images={spina.header_images.images}/>
    {/key}
  </div>
{:else}
  <div class="h-200px"></div>
{/if}


<main class="container">
  <h1>{$store.t('Your message to us')}</h1>
  {#if flash.success}
    <div class="alert alert-success">
      {$store.t('Thank you, your message has been sent')}
    </div>
  {:else}
    <form on:submit|preventDefault={() => $form.post('/forms')}>
      <div class="flex flex-col mt-5">
        <div class="flex-1">
          <label class="block">
            <span class="text-gray-700">{$store.t('Your name')}</span>
            <input type="text" class="form-input mt-1 block w-full" bind:value={$form.name}>
          </label>
        </div>
      <div class="flex flex-col mt-5">
        <div class="flex-1">
          <label class="block">
            <span class="text-gray-700">{$store.t('Your email')}</span>
            <input type="email" class="form-input mt-1 block w-full" bind:value={$form.email}>
          </label>
        </div>
        <div class="flex-1 mt-6">
          <label class="block">
            <span class="text-gray-700">{$store.t('Your message')}</span>
            <textarea class="form-input h-30 mt-1 block w-full" bind:value={$form.text}></textarea>
          </label>
        </div>
      </div>
      <div class="flex mt-6">
        <button class="btn btn-primary">{$store.t('Send')}</button>
      </div>
    </form>
  {/if}
</main>

<style>
  .alert {
    margin-top: 1rem;
  }
  .alert-success {
    background-color: #dff0df;
    border-color: #d0e9c6;
    color: #3c763d;
    padding: 1rem;
  }
  
 h1 {
  text-align: center;
  letter-spacing: 0.3em;
  margin-bottom: 3rem;
  font-size: 2rem;
  text-transform: uppercase;
}

</style>