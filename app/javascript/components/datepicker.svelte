<script>
  import { fly } from 'svelte/transition'
  import { createEventDispatcher } from 'svelte'
  
  // import SimpleBar from '@woden/svelte-simplebar'
  const dispatch = createEventDispatcher()
  export let locale = 'de'
  
  
  const translations = {
    de: {
      monthNames: ["Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"],
      dayNames: ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"],
      firstDayOfWeek: 1,
    },
    en: {
      monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
      dayNames: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
      firstDayOfWeek: 0,
    },
    es: {
      monthNames: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
      dayNames: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
      firstDayOfWeek: 1,
    }
  }
  
  let weekDays = []
  $: firstDayOfWeek = translations[locale].firstDayOfWeek
  $: {
    weekDays = []
    for (let i = 0; i < 7; i++) {
      weekDays.push(translations[locale].dayNames[(i + translations[locale].firstDayOfWeek) % 7])
    }
  }
  $: monthNames = translations[locale].monthNames

  let today = new Date()
  let todayDay = today.getDate()
  let todayMonth = today.getMonth()
  let todayYear = today.getFullYear()
  let inX = 0
  export let hoveredDay

  export let first = false
  export let last = false
  
  export let availableTimes = ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00','07:00', '08:00', '09:00','10:00', '11:00', '12:00','13:00', '14:00', '15:00', '16:00', '17:00', '18:00','19:00', '20:00', '21:00','22:00', '23:00']
  export let value
  export let selectIndex = 0

  $: date1 = value[0]
  $: date2 = value[1]

  export let calendarMonth = date1 || new Date()
  
  $: dispatch('monthChanged', calendarMonth)

  export let times = false
  
  export let blockedRanges = []
  export let min = new Date(new Date().getTime() - 60 * 60 * 24 * 1000)
  // TODO: split selectedTime into selectedHour and selectedMinute and make better UI

  // if (typeof(value) == 'string') value = new Date(value)
  // let selectedTime = date1?.getHours().toString().padStart(2, '0') + ':00'
  $: {
    if (typeof(value[0]) == 'string') value[0] = new Date(value[0])
  }
  function addZero(val) {
    return val.toString().length < 2 ? '0' + val : val
  }
  
  
  $: displayDays = getCalendarDays(new Date(calendarMonth.getFullYear(), calendarMonth.getMonth(), 1))

  function selectDay(day) {
    if (day < min) return
    value[selectIndex] = day
    if (selectIndex == 0) value[1] = undefined
    selectIndex++
    if (selectIndex == 2) {
      selectIndex = 0
    }
    if (value[0] > value[1]) {
      let tmp = value[0]
      value[0] = value[1]
      value[1] = tmp
    }
    // value[index].setHours(selectedTime.substr(0,2))
    // value[index].setMinutes(selectedTime.substr(3,2))
    // if (autoclose) tick().then(() => opened = false)
    dispatch('change', value)
  }
  function isSelected(day) {
    if (!date1) return false
    if (day.getDate() == date1.getDate() && day.getMonth() == date1.getMonth() && day.getFullYear() == date1.getFullYear()) return true
    if (date2) {
      if (day.getDate() == date2.getDate() && day.getMonth() == date2.getMonth() && day.getFullYear() == date2.getFullYear()) return true
    }
  }
  function isInRange(day) {
    let start = date1
    let end = date2 || hoveredDay
    if (end < start) {
      let tmp = end
      end = start
      start = tmp
    }
    if (!start || !end) return false
    if (day < start) return false
    if (day > end) return false
    return true
  }
  function getCalendarDays(month) {
      // Get previous firstDayOfWeek if today (the 1st) isn't a Sunday
      const cursor =
        month.getDay() === firstDayOfWeek
          ? new Date(month)
          : new Date(new Date(month).setDate(month.getDate() - month.getDay() + firstDayOfWeek));
      const days = [];
      let hasMoredays = true;
      // i is a safety net for infinite loops crashing script in
      // case my logic is bad.
      let i = 0;
      do {
        if (cursor.getMonth() === month.getMonth()) {
          days.push(new Date(cursor));
        }
        else {
          days.push(null);
        }
        cursor.setDate(cursor.getDate() + 1);
        i++;
        const cmonth = cursor.getMonth();
        const cyear = cursor.getFullYear();
        const mmonth = month.getMonth();
        const myear = month.getFullYear();
        hasMoredays = !(cyear > myear) || (cyear <= myear && cmonth <= mmonth);
      } while (hasMoredays && i < 40);
      return days;
    };
  </script>
  

  
    <div class="datepicker">
      <div class="calendar">
        <div class="month">
          {#each [calendarMonth] as calendarMonth (calendarMonth)}
            <div class="name" in:fly|local={{x: inX * 50}}>{monthNames[calendarMonth.getMonth()]} {calendarMonth.getFullYear()}</div>
          {/each}
        </div>
        <div class="week">
        <!-- {#each [calendarMonth] as calendarMonth (calendarMonth)} -->
          {#each weekDays as weekDay}
            <div class="weekday">
              {weekDay}
            </div>
          {/each}
          <div class="border"></div>
          <!-- {/each} -->
          {#each displayDays as day, i (i+day)}
            {#if day}
  
              <div class="day"
                on:mousemove={() => hoveredDay = day}
                class:disabled={day < min}
                class:selected={isSelected(day, value)}
                class:inrange={isInRange(day, value, hoveredDay)}
                class:today={todayDay == day.getDate() && todayMonth == day.getMonth() && todayYear == day.getFullYear()}
                on:click={() => selectDay(day)}>
                {day.getDate()}
              </div>
  
            {:else}
              <div class="day"></div>
            {/if}
          {/each}
        </div>
      </div>
  
    </div>
  

  
  <style>


  .calendar {
    width: 100%;
  }
  .datepicker {
    /* position: absolute; */
    
    width: 100%;
    
    display: inline-flex;
    user-select: none;
  }
  .week .border {
    border: none;
    border-bottom: 1px solid #ccc;
    width: 100%;
    grid-column: 1 / span 7;
  }

  .month {
    margin-bottom: 0.8em;
    font-size: 1.4em;
    text-align: center;
    height: 20px;
    position: relative;
  }
  .next {
    float: right;
  }
  .prev {
    float: left;
  }
  .month .name {
    position: absolute;
    vertical-align: middle;
    display: inline-block;
    width: 100%;
    left: 0;
  }
  .nav {
    position: absolute;
    width: 100%;
  }
  .week {
    width: 100%;
    display: grid;
    justify-items: center;
    grid-template-columns: auto auto auto auto auto auto auto;
  }
  .weekday {
    font-size: 0.7em;
    margin-bottom: 6px;
  }
  .timelist {
    position: absolute;
    height: calc(100% - 16px);
    overflow-y: scroll;
    overflow-x: hidden;
    right: 0;
    padding-right: 4px;
    margin: 8px;
    margin-right: 0;
  }
  .time {
    position: relative;
    cursor: pointer;
    z-index: 1;
    padding: 2px 4px;
  }
  .inrange::after {
    content: '';
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    position: absolute;
    background: #e2d6ca;
    /* animation-name: zoom-in;
    animation-duration: 0.3s;
    animation-timing-function: ease-out; */
    z-index: -1;
  }
  .selected::after {
    content: '';
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    position: absolute;
    background: #9e8a74;
    animation-name: zoom-in;
    animation-duration: 0.3s;
    animation-timing-function: ease-out;
    z-index: -1;
  }

  .day {
    position: relative;
    line-height: 2.8em;
    width: 100%;
    text-align: center;
    cursor: pointer;
    z-index: 2;
  }
  .day.selected {
    color: white;
  }
  .day.disabled {
    opacity: 0.3;
  }
  .day.today {
    border: 1px solid #927B62;
  }
  @keyframes zoom-in {
      0% {
        transform: scale(0.1);
      }
      50% {
        transform: scale(1.15);
      }
      100% {
        transform: scale(1);
      }
    }
  </style>