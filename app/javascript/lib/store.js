import { writable } from "svelte/store"
import translations from '~/lib/translations'
const locale = document.getElementsByTagName('html')[0].getAttribute('lang')


const t = function(key) {
  return translations[locale][key.toLowerCase().replace(/ /g, '_')] || key
}

export default writable({
  locale,
  t 
})