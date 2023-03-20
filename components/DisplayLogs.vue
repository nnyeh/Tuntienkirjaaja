<template>
  <div>
    <div v-if="pending" class="flex justify-center">
      <Icon name="eos-icons:loading" size="3em" class="text-gray-700" />
    </div>
    <div v-else-if="error" class="flex justify-center">
      Jotain meni pieleen, ota yhteyttä ylläpitoon.
    </div>
    <ul class="grid pr-10 pl-10 gap-4 mb-4">
      <li v-for="(log, index) in logs?.body.slice().reverse()" :key="index">
        <p class="border-2 border-black p-2 bg-emerald-100">
          <b>Päivämäärä:</b> {{ log.date }}
          <br>
          <b>Aloitusaika:</b> {{ log.startTime }}
          <br>
          <b>Lopetusaika:</b> {{ log.endTime }}
          <br>
          <b>Työtehtävä:</b> {{ log.task }}
          <br>
          <b>Selitys:</b> {{ log.description }}
        </p>
      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
const { data } = useSession()
const { data: logs, pending, error } = await useFetch('/showlogs', { method: 'POST', body: JSON.stringify({ email: data.value?.user?.email }) })
</script>
