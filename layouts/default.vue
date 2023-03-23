<template>
  <div class="flex justify-center min-h-screen min-w-screen bg-gray-400">
    <div id="scroll-shadows">
      <div
        id="white"
        class="font-mono absolute top-0 right-0 bottom-0 left-0 m-auto text-black border-2 border-black bg-white
          text-xl lg:text-xl select-none gap-20 w-[90%] lg:w-[65%] xl:w-[50%] h-[95%] overflow-y-auto overflow-x-hidden"
      >
        <slot />
      </div>
    </div>
  </div>
</template>

<style scoped>

#white::-webkit-scrollbar {
  display: none;
}

#scroll-shadows {
  max-height: 200px;
  overflow: auto;
  -webkit-overflow-scrolling: touch;
  background:
    linear-gradient(
      white 30%,
      rgba(255, 255, 255, 0)
    ) center top,
    linear-gradient(
      rgba(255, 255, 255, 0)
      white 70%
    ) center bottom,
    radial-gradient(
      farthest-side at 50% 0,
      rgba(0, 0, 0, 0.2),
      rgba(0, 0, 0, 0)
    ) center top,
    radial-gradient(
      farthest-side at 50% 100%,
      rgba(0, 0, 0, 0.2),
      rgba(0, 0, 0, 0)
    ) center bottom;
  background-repeat: no-repeat;
  background-size: 100% 40px, 100% 40px, 100% 14px, 100% 14px;
  background-attachment: local, local, scroll, scroll;
}

</style>
