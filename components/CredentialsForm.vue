<template>
  <div class="flex justify-center overflow-y-auto overflow-x-hidden min-h-screen min-w-screen bg-gray-400">
    <div
      class="font-mono flex flex-col justify-center text-black border-2 border-black m-10 bg-white
      text-xl lg:text-xl select-none gap-20 w-[80%] lg:w-[50%]"
    >
      <form class="flex flex-col text-center items-center gap-2" @submit="registerNewUser">
        <span class="text-3xl lg:text-4xl pb-6 p-10 pt-6">
          SAMPLE TEXT
        </span>
        <label id="top" style="margin-top: 2.5rem" for="email">Sähköposti*</label>
        <input
          v-model="email"
          type="text"
          spellcheck="false"
          pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
          placeholder="nimi@sposti"
          class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 focus:border-4 border-black w-[80%] transition-all duration-75 text-lg placeholder:text-gray-500"
          required
          @keydown.enter.prevent
        >
        <div id="names" style="display: none; transform: scale(0);" class="grid-flow-row md:grid-cols-2 w-[80%] gap-4 transition-all duration-150">
          <div class="flex flex-col items-center">
            <label for="email">Etunimi*</label>
            <input
              v-model="firstName"
              type="text"
              spellcheck="false"
              class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-400 lg:focus:bg-yellow-100 focus focus:outline-none h-12 text-center
              border-2 focus:border-4 border-black w-[100%] transition-all duration-75 text-lg"
              required
              @keydown.enter.prevent
            >
          </div>
          <div class="flex flex-col items-center">
            <label for="email">Sukunimi*</label>
            <input
              v-model="lastName"
              type="text"
              spellcheck="false"
              class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
              border-2 focus:border-4 border-black w-[100%] transition-all duration-75 text-lg"
              required
              @keydown.enter.prevent
            >
          </div>
        </div>
        <label for="password">Salasana*</label>
        <input
          v-model="password"
          :type="fieldType"
          spellcheck="false"
          autocomplete="off"
          pattern=".{8,}"
          placeholder="Vähintään 8 merkkiä"
          class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 focus:border-4 border-black w-[80%] transition-all duration-75 text-lg placeholder:text-gray-500"
          required
          @keydown.enter.prevent
        >
        <label id="bottom" style="margin-bottom: 2.75rem" class="flex justify-center items-center w-[80%] gap-4 mt-2 cursor-pointer">
          Näytä salasana
          <input
            type="checkbox"
            class="checked:bg-emerald-300 checked:hover:bg-yellow-100 hover:bg-gray-400
            checked:border-4 border-2 border-black w-8 h-8 aspect-square transition-all duration-75 cursor-pointer"
            @click="togglePasswordVisibility"
          >
        </label>
        <div class="flex flex-wrap-reverse justify-center gap-14 p-10 pb-6">
          <span
            id="registerToggle"
            style="background-color: rgb(224 242 254 / var(--tw-bg-opacity));"
            class="hover:bg-gray-300 border-2 border-black p-4 transition-colors duration-150 cursor-pointer"
            @click="toggleRegistering"
          >
            Rekisteröidytkö?
          </span>
          <button
            id="loginButton"
            :disabled="!email || !password"
            style="display: block"
            class="bg-emerald-300 hover:bg-emerald-200 disabled:bg-red-300 disabled:hover:bg-red-200 disabled:cursor-not-allowed transition-colors duration-150"
            @click="signIn('credentials', { email: email, password: password })"
          >
            <span class="border-4 border-black p-4 transition-colors duration-150">Kirjaudu</span>
          </button>
          <button
            id="registerButton"
            :disabled="!email || !firstName || !lastName || !password"
            style="display: none"
            type="submit"
            value="registerNewUser"
            class="bg-sky-300 hover:bg-sky-200 disabled:bg-red-300 disabled:hover:bg-red-200 disabled:cursor-not-allowed transition-colors duration-150"
          >
            <span class="border-4 border-black p-4">Rekisteröidy</span>
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

function toggleRegistering () {
  const names = document.getElementById("names")
  const top = document.getElementById("top")
  const bottom = document.getElementById("bottom")
  const registerToggle = document.getElementById("registerToggle")
  const loginButton = document.getElementById("loginButton")
  const registerButton = document.getElementById("registerButton")

  if (names!.style.display === "none") {
    names!.style.display = "grid"
    names!.style.transform = "scale(1)"
    top!.style.marginTop = "0rem"
    bottom!.style.marginBottom = "0rem"
    registerToggle!.style.backgroundColor = "rgb(209 250 229 / var(--tw-bg-opacity))"
    registerToggle!.innerText = "Kirjaudutko?"
    loginButton!.style.display = "none"
    registerButton!.style.display = "block"
  } else {
    names!.style.display = "none"
    names!.style.transform = "scale(0)"
    top!.style.marginTop = "2.5rem"
    bottom!.style.marginBottom = "2.75rem"
    registerToggle!.style.backgroundColor = "rgb(224 242 254 / var(--tw-bg-opacity))"
    registerToggle!.innerText = "Rekisteröidytkö?"
    loginButton!.style.display = "block"
    registerButton!.style.display = "none"
  }
}

</script>

<style scoped>

input[type="checkbox"] {
  -webkit-appearance: none;
  appearance: none;
  margin: 0;
}

</style>
