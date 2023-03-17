<template>
  <div v-if="status === 'authenticated'">
    <p class="text-lg">
      Authenticated
    </p>
    <button
      class="flex items-center justify-center space-x-2 bg-red-500 text-white rounded-lg py-2 px-3 text-lg"
      @click="signOut({ callbackUrl: '/' })"
    />
  </div>
</template>

<script setup lang="ts">
const { status, signOut } = useSession()
</script>

<style scoped>

</style>
