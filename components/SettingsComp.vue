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
    <form class="flex flex-col items-center gap-2 mt-4" @submit="addNewCostPool">
      <label for="date">Kustannuspaikka</label>
      <input
        v-model="costpool"
        list="costpools"
        spellcheck="false"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[56%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <datalist id="costpools">
        <option v-for="(preset, index) in presets?.costpools" :key="index">
          {{ preset.costpool }}
        </option>
      </datalist>
      <div class="grid grid-cols-2 gap-4 mt-4 pl-10 pr-10">
        <button
          type="submit"
          value="addNewCostPool"
          :disabled="!costpool"
          class="text-lg lg:text-xl text-center border-2
        bg-emerald-300 hover:bg-emerald-200 disabled:bg-emerald-100 disabled:hover:bg-emerald-50 disabled:cursor-not-allowed transition-colors duration-150
        border-black p-2 mb-4"
        >
          <span>
            Lisää
          </span>
        </button>
        <button
          :disabled="!costpool"
          class="text-lg lg:text-xl text-center border-2
        bg-red-300 hover:bg-red-200 disabled:bg-red-100 disabled:hover:bg-red-50 disabled:cursor-not-allowed transition-colors duration-150
        border-black p-2 mb-4"
        >
          <span>
            Poista
          </span>
        </button>
      </div>
    </form>
    <form class="flex flex-col items-center gap-2 mt-4" @submit="addNewTask">
      <label for="date">Työtehtävä</label>
      <input
        v-model="task"
        list="tasks"
        spellcheck="false"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[56%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <datalist id="tasks">
        <option v-for="(preset, index) in presets?.tasks" :key="index">
          {{ preset.task }}
        </option>
      </datalist>
      <div class="grid grid-cols-2 gap-4 mt-4 pl-10 pr-10">
        <button
          type="submit"
          value="addNewTask"
          :disabled="!task"
          class="text-lg lg:text-xl text-center border-2
        bg-emerald-300 hover:bg-emerald-200 disabled:bg-emerald-100 disabled:hover:bg-emerald-50 disabled:cursor-not-allowed transition-colors duration-150
        border-black p-2 mb-4"
        >
          <span>
            Lisää
          </span>
        </button>
        <button
          :disabled="!task"
          class="text-lg lg:text-xl text-center border-2
        bg-red-300 hover:bg-red-200 disabled:bg-red-100 disabled:hover:bg-red-50 disabled:cursor-not-allowed transition-colors duration-150
        border-black p-2 mb-4"
        >
          <span>
            Poista
          </span>
        </button>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">

const costpool = ref("")
const task = ref("")

const addNewCostPool = async () => {
  const body = {
    email: data.value?.user?.email,
    costpool: costpool.value
  }
  await fetch("/addcostpoolpreset", {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  })
}

const addNewTask = async () => {
  const body = {
    email: data.value?.user?.email,
    task: task.value
  }
  await fetch("/addtaskpreset", {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  })
}

const { data } = useSession()
const { data: presets } = await useFetch('/showpresets', { method: 'POST', body: JSON.stringify({ email: data.value?.user?.email }) })

</script>

<style scoped>

[list]::-webkit-calendar-picker-indicator {
  display: none !important;
}

</style>
