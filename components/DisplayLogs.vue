<template>
  <div class="pr-10 pl-10">
    <span class="flex justify-center text-center bg-orange-300 border-4 border-dashed border-black p-2 ">
      Muista aina lisätä tekemäsi tunnit tänne heti työnteon jälkeen!
    </span>
    <span v-if="pending" class="flex justify-center">
      <Icon name="eos-icons:loading" size="3em" class="text-gray-700" />
    </span>
    <span v-else-if="error" class="flex justify-center">
      Jotain meni pieleen, ota yhteyttä ylläpitoon.
    </span>
    <span v-if="isItEmpty()" class="flex justify-center bg-emerald-100 border-2 border-black p-2 mt-4">
      Sinulla ei ole vielä kirjauksia.
    </span>
    <ul id="ul" class="grid gap-4 mb-4 mt-4">
      <li v-for="(log, index) in logs?.body.slice().reverse()" :key="index">
        <p class="border-2 border-black p-2 bg-emerald-100">
          <b>Päivämäärä:</b> {{ log.date }}
          <br>
          <b>Aloitusaika:</b> {{ log.startTime }}
          <br>
          <b>Lopetusaika:</b> {{ log.endTime }}
          <br>
          <b>Lopetusaika:</b> {{ log.costPool }}
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

function isItEmpty () {
  if (document.getElementById("ul")?.innerText === "") {
    return true
  }
  return false
}

const { data } = useSession()
const { data: logs, pending, error } = await useLazyFetch('/showlogs', { method: 'POST', body: JSON.stringify({ email: data.value?.user?.email }) })
</script>
