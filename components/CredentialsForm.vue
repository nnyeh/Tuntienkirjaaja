<template>
  <div class="flex justify-center overflow-hidden min-h-screen bg-gray-400">
    <div
      class="font-mono flex flex-col justify-center text-black border-2 border-black m-10 bg-white
      text-2xl lg:text-xl select-none gap-20 w-[80%] lg:w-[50%]"
    >
      <form class="flex flex-col text-center items-center gap-2" @submit="registerNewUser">
        <span class="text-4xl lg:text-5xl mb-6">
          SAMPLE TEXT
        </span>
        <label for="email">Sähköposti</label>
        <input
          v-model="email"
          type="text"
          spellcheck="false"
          class="bg-gray-300 hover:bg-green-300 lg:hover:bg-gray-400 lg:focus:bg-green-300 focus:outline-none h-12 text-center
          border-2 focus:border-4 border-black w-[80%] transition-colors duration-150 text-xl lg:text-lg"
          required
        >
        <div class="grid grid-flow-row md:grid-cols-2 w-[80%] gap-4">
          <div class="flex flex-col items-center">
            <label for="email">Etunimi</label>
            <input
              v-model="firstName"
              type="text"
              spellcheck="false"
              class="bg-gray-300 hover:bg-green-300 lg:hover:bg-gray-400 lg:focus:bg-green-300 focus focus:outline-none h-12 text-center
              border-2 focus:border-4 border-black w-[100%] transition-colors duration-150 text-xl lg:text-lg"
              required
            >
          </div>
          <div class="flex flex-col items-center">
            <label for="email">Sukunimi</label>
            <input
              v-model="lastName"
              type="text"
              spellcheck="false"
              class="bg-gray-300 hover:bg-green-300 lg:hover:bg-gray-400 lg:focus:bg-green-300 focus:outline-none h-12 text-center
              border-2 focus:border-4 border-black w-[100%] transition-colors duration-150 text-xl lg:text-lg"
              required
            >
          </div>
        </div>
        <label for="password">Salasana</label>
        <input
          v-model="password"
          :type="fieldType"
          spellcheck="false"
          autocomplete="off"
          class="bg-gray-300 hover:bg-green-300 lg:hover:bg-gray-400 lg:focus:bg-green-300 focus:outline-none h-12 text-center
          border-2 focus:border-4 border-black w-[80%] transition-colors duration-150 text-xl lg:text-lg"
          required
        >
        <label class="flex justify-center items-center w-[80%] gap-4 mb-6 mt-2">
          Näytä salasana
          <input
            type="checkbox"
            class="checked:bg-green-300 checked:hover:bg-green-300 hover:bg-gray-400
            border-2 border-black w-8 h-8 aspect-square transition-colors duration-150"
            @click="togglePasswordVisibility"
          >
          <span class="checked:fill-green-300 checked:p-2" />
        </label>
        <div class="flex flex-wrap-reverse justify-center gap-14 p-10 pb-6">
          <button type="submit" value="registerNewUser">
            <span>Rekisteröidy</span>
          </button>
          <button @click="signIn('credentials', { email: email, password: password })">
            <span class="bg-green-300 hover:bg-green-200 border-4 border-black p-4 transition-colors duration-150">Kirjaudu</span>
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">

const { signIn } = useSession()

const router = useRouter()

const registerNewUser = async () => {
  try {
    const body = {
      email: email.value,
      firstName: firstName.value,
      lastName: lastName.value,
      password: password.value
    }
    await fetch(`/user`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body)
    })
      .then(() => {
        router.push({ path: '/' })
      })
      .catch((error) => {
        console.error(error)
      })
  } catch (error) {
    console.error(error)
  }
}

const email = ref()
const firstName = ref()
const lastName = ref()
const password = ref()
const fieldType = ref("password")

function togglePasswordVisibility () {
  fieldType.value = fieldType.value === "text" ? "password" : "text"
}

</script>

<style scoped>

input[type="checkbox"] {
  -webkit-appearance: none;
  appearance: none;
  margin: 0;
}

</style>
