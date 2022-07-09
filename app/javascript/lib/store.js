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
    'select_dates': 'Termine auswählen',
    'your_message_to_us': 'Ihre Nachricht an uns',
    'your_name': 'Ihr Name',
    'your_email': 'Ihre E-Mail',
    'your_message': 'Ihre Nachricht',
    'thank_you,_your_message_has_been_sent': 'Vielen Dank, Ihre Nachricht wurde gesendet',
    'send': 'Abschicken',
    'contact_us': 'Kontaktieren Sie uns',
    'language': 'Sprache',
    'information': 'Informationen',
    'more_information': 'Mehr informationen',
    'all_categories': 'Alle Kategorien',
    'back_to_overview': 'Zurück zur Übersicht'
  },
  en: {
    'sleeps': 'Sleeps',
    'king_size_bed': 'King size bed',
    'queen_size_bed': 'Queen size bed',
    'single_bed': 'Single bed',
    'bathtub': 'Bathtub',
  },
  es: {
    'checkin': 'Check-in',
    'checkout': 'Check-out',
    'adults': 'Adultos',
    'children': 'Niños',
    'check_availability': 'Comprobar disponibilidad',
    'sleeps': 'Dormitorios',
    'king_size_bed': 'King size bed',
    'queen_size_bed': 'Queen size bed',
    'single_bed': 'Single bed',
    'bathtub': 'Bathtub',
    'select_dates': 'Seleccionar fechas',
    'your_message_to_us': 'Su mensaje a nosotros',
    'your_name': 'Su nombre',
    'your_email': 'Su correo electrónico',
    'your_message': 'Su mensaje',
    'thank_you,_your_message_has_been_sent': 'Gracias, su mensaje ha sido enviado',
    
  }
}
const t = function(key) {
  return translations[locale][key.toLowerCase().replace(/ /g, '_')] || key
}

export default writable({
  locale,
  t 
})