import { writable } from "svelte/store"

const locale = document.getElementsByTagName('html')[0].getAttribute('lang')

const translations = {
  de: {
    'checkin': 'Check-in',
    'checkout': 'Check-out',
    'adults': 'Erwachsene',
    'children': 'Kinder',
    'check_availability': 'Verfügbarkeit prüfen',
    'sleeps': 'Schlafplätze',
    'king_size_bed': 'Kingsize-Bett',
    'queen_size_bed': 'Doppelbett',
    'bathtub': 'Badewanne',
    'single_bed': 'Einzelbett',
    'select_dates': 'Termine auswählen'
  },
  en: {
    'sleeps': 'Sleeps',
    'king_size_bed': 'King size bed',
    'queen_size_bed': 'Queen size bed',
    'single_bed': 'Single bed',
    'bathtub': 'Bathtub',
  }
}
const t = function(key) {
  return translations[locale][key.toLowerCase().replace(/ /g, '_')] || key
}

export default writable({
  locale,
  t 
})