<template>
  <div class="max-h-[86.2vh] flex items-start justify-center">
    <form class="flex flex-col items-center gap-2 mt-4 pl-10 pr-10" @submit="addNewLog">
      <span class="text-3xl lg:text-4xl text-center pl-10 pr-10 mb-4">
        Uusi merkintä
      </span>
      <label for="date">Päivämäärä*</label>
      <input
        v-model="dateDone"
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
      <div class="flex items-center justify-center pt-4 gap-4 w-[80%]">
        <Icon name="material-symbols:warning-rounded" size="2.5rem" class="stroke-black text-yellow-300" />
        <span class="text-center text-xs">
          Lisää uusia kustannuspaikkoja
          <br>
          sekä työtehtäviä <NuxtLink to="/asetukset" class="text-purple-400">asetuksista</NuxtLink>.
        </span>
      </div>
      <label for="task" class="pt-4">Kustannuspaikka*</label>
      <select
        v-model="costPool"
        :disabled="presets?.costpools.length === 0"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 disabled:bg-red-300 disabled:hover:bg-red-300
        disabled:cursor-not-allowed focus:outline-none h-12 text-center border-2 border-black w-[100%] transition-all duration-75"
        required
      >
        <option v-for="(preset, index) in presets?.costpools" :key="index">
          {{ preset.costpool }}
        </option>
      </select>
      <label for="task" class="pt-4">Työtehtävä*</label>
      <select
        v-model="task"
        :disabled="presets?.tasks.length === 0"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 disabled:bg-red-300 disabled:hover:bg-red-300
        disabled:cursor-not-allowed focus:outline-none h-12 text-center border-2 border-black w-[100%] transition-all duration-75"
        required
      >
        <option v-for="(preset, index) in presets?.tasks" :key="index">
          {{ preset.task }}
        </option>
      </select>
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
        :disabled="!dateDone || !startTime || !endTime || !task"
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

const { data } = useSession()

const dateDone = ref()
const startTime = ref()
const endTime = ref()
const costPool = ref()
const task = ref()
const description = ref()

const addNewLog = async () => {
  const body = {
    email: data.value?.user?.email,
    dateDone: dateDone.value,
    startTime: startTime.value,
    endTime: endTime.value,
    costPool: costPool.value,
    task: task.value,
    description: description.value
  }
  await fetch("/addlog", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body)
  })
}

const { data: presets } = await useFetch("/showpresets", { method: "POST", body: JSON.stringify({ email: data.value?.user?.email }) })

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
