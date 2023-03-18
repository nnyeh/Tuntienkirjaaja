<template>
  <div class="grid min-[568px]:grid-cols-3 max-[567px]:grid-rows-3 justify-evenly items-center text-center gap-4 pt-4 pb-4 pl-10 pr-10">
    <NuxtLink
      class="border-2 border-black p-2 bg-sky-300 cursor-pointer h-[100%]"
      to="/ajat"
    >
      <span class="flex items-center justify-center h-[100%]">
        Työajat
      </span>
    </NuxtLink>
    <NuxtLink
      class="border-2 border-black p-2 bg-yellow-200 cursor-pointer"
      to="/uusi"
    >
      <span>
        Uusi merkintä
      </span>
    </NuxtLink>
    <div
      class="border-2 border-black p-2 bg-red-300 cursor-pointer"
      @click="signOut({ callbackUrl: '/' })"
    >
      <span>
        Kirjaudu ulos
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
const { signOut } = useSession()
</script>
