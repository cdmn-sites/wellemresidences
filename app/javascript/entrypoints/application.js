import axios from 'axios'

import { createInertiaApp } from '@inertiajs/inertia-svelte'
import { InertiaProgress } from '@inertiajs/progress'

import 'glightbox/dist/css/glightbox.min.css'

import 'virtual:uno.css'

const templates = import.meta.glob('../themes/**/*.svelte')

const csrfToken = document.querySelector('meta[name=csrf-token]').content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

InertiaProgress.init()

// TODO: somehow take theme frome current_account (selected in Spina Admin UI)
const theme = 'default'


createInertiaApp({ 
  resolve: async name => {
    const layout = (await templates[`../themes/${theme}/_layout.svelte`]()).default
    const page = await templates[`../themes/${theme}/${name}.svelte`]()    
    return Object.assign({layout}, page)
  },
  setup({ el, App, props }) {
    new App({ target: el, props })
  },
})