<template>
  <div class="max-h-[86.2vh] flex items-start justify-center">
    <form class="flex flex-col items-center gap-2 mt-4 pl-10 pr-10" @submit="addNewLog">
      <span class="text-3xl lg:text-4xl text-center pl-10 pr-10 mb-4">
        Uusi merkintä
      </span>
      <label for="date">Päivämäärä*</label>
      <input
        v-model="date"
        type="date"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[100%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <label for="startTime" class="pt-4">Aloitusaika*</label>
      <input
        v-model="startTime"
        type="time"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[100%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <label for="endTime" class="pt-4">Lopetusaika*</label>
      <input
        v-model="endTime"
        type="time"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[100%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <label for="task" class="pt-4">Kustannuspaikka*</label>
      <input
        v-model="costPool"
        list="costpools"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[100%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <datalist id="costpools">
        <option v-for="(preset, index) in presets?.costpools.slice().reverse()" :key="index">
          {{ preset.costpool }}
        </option>
      </datalist>
      <label for="task" class="pt-4">Työtehtävä*</label>
      <input
        v-model="task"
        list="tasks"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[100%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <datalist id="tasks">
        <option v-for="(preset, index) in presets?.tasks.slice().reverse()" :key="index">
          {{ preset.task }}
        </option>
      </datalist>
      <span class="text-center text-xs w-[80%] pt-4">
        Voit lisätä kustannuspaikkoja
        <br>
        sekä työtehtäviä
        uudelleenkäyttöä
        <br>
        varten <NuxtLink to="/asetukset" class="text-purple-400">asetuksista</NuxtLink>.
      </span>
      <label for="text" class="pt-2">Selite</label>
      <input
        v-model="description"
        type="text"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[100%] transition-all duration-75 text-base mb-8"
        required
        @keydown.enter.prevent
      >
      <button
        :disabled="!date || !startTime || !endTime || !task"
        class="text-xl lg:text-2xl text-center border-4
        bg-emerald-300 hover:bg-emerald-200 disabled:bg-red-300 disabled:hover:bg-red-200 disabled:cursor-not-allowed transition-colors duration-150
        border-black p-2 pl-10 pr-10 mb-4"
      >
        <span>
          Tallenna
        </span>
      </button>
    </form>
  </div>
</template>

<script setup lang="ts">

import dayjs from 'dayjs'
const { data } = useSession()

const date = ref()
const formattedDate = dayjs(date.value).format('DD.MM.YYYY')
const startTime = ref()
const endTime = ref()
const costPool = ref()
const task = ref()
const description = ref()

const addNewLog = async () => {
  const body = {
    email: data.value?.user?.email,
    date: formattedDate,
    startTime: startTime.value,
    endTime: endTime.value,
    costPool: costPool.value,
    task: task.value,
    description: description.value
  }
  await fetch(`/addlog`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  })
}

const { data: presets } = await useFetch('/showpresets', { method: 'POST', body: JSON.stringify({ email: data.value?.user?.email }) })

</script>

<style scoped>

input[type="date"]::-webkit-calendar-picker-indicator,
input[type="time"]::-webkit-calendar-picker-indicator {
  height: 100%;
  width: auto;
  aspect-ratio: 1/1;
  transform: scale(0.7);
}

input[type="date"]::-webkit-datetime-edit {
  margin-left: 12%
}

input[type="time"]::-webkit-datetime-edit {
  margin-left: 14%
}

[list]::-webkit-calendar-picker-indicator {
  display: none !important;
}

</style>
