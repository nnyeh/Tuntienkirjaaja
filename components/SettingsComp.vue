<template>
  <div class="max-h-[86.2vh] flex flex-col justify-start">
    <span class="text-3xl lg:text-4xl text-center pl-10 pr-10 mt-4 mb-4">
      Asetukset
    </span>
    <hr class="border-black border-2 ml-20 mr-20 mt-4 mb-4">
    <span class="flex self-center lg:text-lg text-center pl-10 pr-10 mt-4 mb-4">
      Lisää tässä kustannuspaikkoja tai työtehtäviä,
      <br>
      joita haluat käyttää uusien merkintöjen luonnissa.
    </span>
    <span class="text-2xl lg:text-3xl text-center pl-10 pr-10 mt-4 mb-4">
      Tallenna tai poista
    </span>
    <div class="flex flex-col items-center gap-2">
      <label for="date" class="mb-4 mt-4">Kustannuspaikka</label>
      <div class="grid min-[686px]:grid-cols-2 max-[685px]:grid-rows-2 gap-4 pl-10 pr-10">
        <form class="flex flex-col items-center gap-4" @submit="addNewCostPool">
          <input
            v-model="costpoolInput"
            spellcheck="false"
            class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
              border-2 border-black transition-all duration-75 text-base w-64"
            required
          >
          <button
            type="submit"
            value="addNewCostPool"
            :disabled="!costpoolInput"
            class="text-lg lg:text-xl text-center border-2
            bg-emerald-300 hover:bg-emerald-200 disabled:bg-emerald-100 disabled:hover:bg-emerald-50 disabled:cursor-not-allowed transition-colors duration-150
            border-black p-2 mb-4"
          >
            <span>
              Lisää
            </span>
          </button>
        </form>
        <form class="flex flex-col items-center gap-4" @submit="deleteCostPool">
          <select
            v-model="costpoolSelect"
            spellcheck="false"
            :disabled="presets?.costpools.length === 0"
            class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
              border-2 border-black transition-all duration-75 text-base w-64"
            required
          >
            <option disabled selected value="">
              Valitse
            </option>
            <option v-for="(preset, index) in presets?.costpools" :key="index">
              {{ preset.costpool }}
            </option>
          </select>
          <button
            type="submit"
            value="deleteCostPool"
            :disabled="!costpoolSelect"
            class="text-lg lg:text-xl text-center border-2
            bg-red-300 hover:bg-red-200 disabled:bg-red-100 disabled:hover:bg-red-50 disabled:cursor-not-allowed transition-colors duration-150
            border-black p-2 mb-4"
          >
            <span>
              Poista
            </span>
          </button>
        </form>
      </div>
    </div>
    <div class="flex flex-col items-center gap-2">
      <label for="date" class="mb-4 mt-4">Työtehtävä</label>
      <div class="grid min-[686px]:grid-cols-2 max-[685px]:grid-rows-2 gap-4 pl-10 pr-10">
        <form class="flex flex-col items-center gap-4" @submit="addNewTask">
          <input
            v-model="taskInput"
            spellcheck="false"
            class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
              border-2 border-black transition-all duration-75 text-base w-64"
            required
          >
          <button
            type="submit"
            value="addNewTask"
            :disabled="!taskInput"
            class="text-lg lg:text-xl text-center border-2
            bg-emerald-300 hover:bg-emerald-200 disabled:bg-emerald-100 disabled:hover:bg-emerald-50 disabled:cursor-not-allowed transition-colors duration-150
            border-black p-2 mb-4"
          >
            <span>
              Lisää
            </span>
          </button>
        </form>
        <form class="flex flex-col items-center gap-4" @submit="deleteTask">
          <select
            v-model="taskSelect"
            spellcheck="false"
            :disabled="presets?.tasks.length === 0"
            class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
              border-2 border-black transition-all duration-75 text-base w-64"
            required
          >
            <option disabled selected value="">
              Valitse
            </option>
            <option v-for="(preset, index) in presets?.tasks" :key="index">
              {{ preset.task }}
            </option>
          </select>
          <button
            type="submit"
            value="deleteTask"
            :disabled="!taskSelect"
            class="text-lg lg:text-xl text-center border-2
            bg-red-300 hover:bg-red-200 disabled:bg-red-100 disabled:hover:bg-red-50 disabled:cursor-not-allowed transition-colors duration-150
            border-black p-2 mb-4"
          >
            <span>
              Poista
            </span>
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">

const costpoolInput = ref("")
const costpoolSelect = ref("")
const taskInput = ref("")
const taskSelect = ref("")

const addNewCostPool = async () => {
  const body = {
    email: data.value?.user?.email,
    costpool: costpoolInput.value
  }
  await fetch("/addcostpoolpreset", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body)
  })
}

const addNewTask = async () => {
  const body = {
    email: data.value?.user?.email,
    task: taskInput.value
  }
  await fetch("/addtaskpreset", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body)
  })
}

const deleteCostPool = async () => {
  const body = {
    email: data.value?.user?.email,
    costpool: costpoolSelect.value
  }
  await fetch("/deletecostpoolpreset", {
    method: "POST",
    body: JSON.stringify(body)
  })
}

const deleteTask = async () => {
  const body = {
    email: data.value?.user?.email,
    task: taskSelect.value
  }
  await fetch("/deletetaskpreset", {
    method: "POST",
    body: JSON.stringify(body)
  })
}

const { data } = useSession()
const { data: presets } = await useFetch("/showpresets", { method: "POST", body: JSON.stringify({ email: data.value?.user?.email }) })

</script>

<style scoped>

/* Jostain syystä jos tämän poistaa niin antaa harmitonta 'Unknown word' erroria, älä kysy miksi */
[list]::-webkit-calendar-picker-indicator {
  display: none !important;
}

</style>
