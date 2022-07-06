import axios from 'axios'

import { createInertiaApp } from '@inertiajs/inertia-svelte'
import { InertiaProgress } from '@inertiajs/progress'
import { Inertia } from '@inertiajs/inertia'
import 'glightbox/dist/css/glightbox.min.css'

// import ibe from '~/lib/ibe'

import 'virtual:uno.css'

// Inertia.on('navigate', () => ibe.go())

const templates = import.meta.glob('../themes/**/*.svelte')

const csrfToken = document.querySelector('meta[name=csrf-token]').content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

InertiaProgress.init()


createInertiaApp({ 
  resolve: async name => {
    const layout = (await templates[`../themes/${window.theme}/_layout.svelte`]()).default
    const page = await templates[`../themes/${window.theme}/${name}.svelte`]()    
    return Object.assign({layout}, page)
  },
  setup({ el, App, props }) {
    new App({ target: el, props })
  },
})