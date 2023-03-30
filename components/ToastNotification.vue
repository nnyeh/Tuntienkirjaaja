<template>
  <div class="border-4 border-black w-[80%] top-10">
    <span class="flex justify-center text-center p-2 bg-orange-300">
      {{ message }}
    </span>
  </div>
</template>

<script setup lang="ts">
const message = ref("")
</script>
