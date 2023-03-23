<template>
  <span class="flex justify-center pt-4 text-2xl">
    Hei {{ user?.body?.firstName }}!
  </span>
  <div class="grid min-[759px]:grid-cols-4 max-[758px]:grid-rows-4 justify-evenly items-center text-center gap-4 pt-4 pb-4 pl-10 pr-10">
    <NuxtLink
      class="border-2 border-black p-2 bg-sky-300 hover:bg-sky-200 cursor-pointer h-[100%]"
      to="/ajat"
    >
      <span class="flex items-center justify-center h-[100%]">
        Työajat
      </span>
    </NuxtLink>
    <NuxtLink
      class="border-2 border-black p-2 bg-yellow-200 hover:bg-yellow-100 cursor-pointer"
      to="/uusi"
    >
      <span>
        Uusi merkintä
      </span>
    </NuxtLink>
    <NuxtLink
      class="border-2 border-black p-2 bg-purple-300 hover:bg-purple-200 cursor-pointer h-[100%]"
      to="/asetukset"
    >
      <span class="flex items-center justify-center h-[100%]">
        Asetukset
      </span>
    </NuxtLink>
    <div
      class="border-2 border-black p-2 bg-red-300 hover:bg-red-200 cursor-pointer"
      @click="signOut({ callbackUrl: '/' })"
    >
      <span>
        Kirjaudu ulos
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
const { data, signOut } = useSession()
const { data: user } = await useFetch('/showuser', { method: 'POST', body: JSON.stringify({ email: data.value?.user?.email }) })
</script>
