import axios from 'axios'

import { createInertiaApp } from '@inertiajs/inertia-svelte'
import { InertiaProgress } from '@inertiajs/progress'

import 'virtual:uno.css'

const pages = import.meta.glob('../pages/**/*.svelte')

const csrfToken = document.querySelector('meta[name=csrf-token]').content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

InertiaProgress.init()

// TODO: somehow take theme frome current_account (selected in Spina Admin UI)
const theme = 'default'
import Layout from '../pages/default/_layout.svelte'

createInertiaApp({ 
  resolve: async name => {
    const page = await pages[`../pages/${theme}/${name}.svelte`]()
    return Object.assign({layout: Layout}, page)
  },
  setup({ el, App, props }) {
    new App({ target: el, props })
  },
})