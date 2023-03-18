<template>
  <div class="max-h-[86.2vh] flex items-start justify-center">
    <form class="flex flex-col items-center gap-2 mt-4" @submit="addNewLog">
      <span class="text-3xl lg:text-4xl text-center pl-10 pr-10 mb-4">
        Uusi merkintä
      </span>
      <label for="date">Päivämäärä*</label>
      <input
        v-model="date"
        type="date"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[80%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <label for="date" class="pt-4">Aloitusaika*</label>
      <input
        v-model="startTime"
        type="time"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[80%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <label for="date" class="pt-4">Lopetusaika*</label>
      <input
        v-model="endTime"
        type="time"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[80%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <label for="date" class="pt-4">Työtehtävä*</label>
      <input
        v-model="task"
        type="text"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[80%] transition-all duration-75 text-base"
        required
        @keydown.enter.prevent
      >
      <label for="date" class="pt-4">Selite</label>
      <input
        v-model="description"
        type="text"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[80%] transition-all duration-75 text-base mb-8"
        required
        @keydown.enter.prevent
      >
      <button
        :disabled="!date || !startTime || !endTime || !task"
        class="text-2xl lg:text-3xl text-center border-4
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

const date = ref()
const startTime = ref()
const endTime = ref()
const task = ref()
const description = ref()

const addNewLog = async () => {
  try {
    const body = {
      email: data.value?.user?.email,
      date: date.value,
      startTime: startTime.value,
      endTime: endTime.value,
      task: task.value,
      description: description.value
    }
    await fetch(`/logs`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body)
    })
  } catch (error) {
    console.error(error)
  }
}

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
  margin-left: 18%
}

input[type="time"]::-webkit-datetime-edit {
  margin-left: 20%
}

</style>
