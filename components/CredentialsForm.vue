<template>
  <div class="min-h-[94.3vh] flex items-center justify-center">
    <form class="flex flex-col text-center items-center gap-2" @submit="registerNewUser">
      <span class="text-3xl lg:text-4xl pb-6 p-10 pt-6">
        Tuntikirjuri
      </span>
      <label id="top" for="email">Sähköposti*</label>
      <input
        v-model="email"
        type="text"
        spellcheck="false"
        pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
        placeholder="nimi@sposti"
        class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus:outline-none h-12 text-center
          border-2 border-black w-[80%] transition-all duration-75 text-base placeholder:text-gray-500"
        required
        @keydown.enter.prevent
      >
      <div id="names" style="display: none;" class="grid-flow-row md:grid-cols-2 w-[80%] gap-4 transition-all duration-150">
        <div class="flex flex-col items-center">
          <label for="email">Etunimi*</label>
          <input
            v-model="firstName"
            type="text"
            spellcheck="false"
            class="bg-gray-300 hover:bg-yellow-100 lg:hover:bg-gray-300 lg:focus:bg-yellow-100 focus focus:outline-none h-12 text-center
              border-2 border-black w-[100%] transition-all duration-75 text-base"
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
              border-2 border-black w-[100%] transition-all duration-75 text-base"
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
          border-2 border-black w-[80%] transition-all duration-75 text-base placeholder:text-gray-500"
        required
        @keydown.enter.prevent
      >
      <label id="bottom" class="flex justify-center items-center w-[80%] gap-4 mt-2 cursor-pointer">
        Näytä salasana
        <input
          type="checkbox"
          class="checked:bg-yellow-100 checked:hover:bg-yellow-100 hover:bg-gray-400
            checked:border-4 border-2 border-black w-8 h-8 aspect-square transition-all duration-75 cursor-pointer"
          @click="togglePasswordVisibility"
        >
      </label>
      <div class="flex flex-wrap-reverse justify-center gap-7 p-10 pb-6">
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
          type="button"
          :disabled="!email || !password || password.length < 8"
          style="display: block"
          class="bg-emerald-300 hover:bg-emerald-200 disabled:bg-red-300 disabled:hover:bg-red-200 disabled:cursor-not-allowed transition-colors duration-150"
          @click="signIn('credentials', { email: email, password: password, callbackUrl: '/uusi' })"
        >
          <p class="border-4 border-black p-4 transition-colors duration-150">
            Kirjaudu
          </p>
        </button>
        <button
          id="registerButton"
          :disabled="!email || !firstName || !lastName || !password || password.length < 8"
          style="display: none"
          type="submit"
          value="registerNewUser"
          class="bg-sky-300 hover:bg-sky-200 disabled:bg-red-300 disabled:hover:bg-red-200 disabled:cursor-not-allowed transition-colors duration-150"
        >
          <p class="border-4 border-black p-4">
            Rekisteröidy
          </p>
        </button>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">

const { signIn } = useSession()

const router = useRouter()

const email = ref("")
const firstName = ref("")
const lastName = ref("")
const password = ref("")
const fieldType = ref("password")

function togglePasswordVisibility () {
  fieldType.value = fieldType.value === "text" ? "password" : "text"
}

const registerNewUser = async () => {
  const body = {
    email: email.value,
    firstName: firstName.value,
    lastName: lastName.value,
    password: password.value
  }
  await fetch("/createuser", {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  })
    .then(() => {
      router.push({ path: '/' })
    })
}

function toggleRegistering () {
  const names = document.getElementById("names")
  const registerToggle = document.getElementById("registerToggle")
  const loginButton = document.getElementById("loginButton")
  const registerButton = document.getElementById("registerButton")

  if (names!.style.display === "none") {
    names!.style.display = "grid"
    registerToggle!.style.backgroundColor = "rgb(209 250 229 / var(--tw-bg-opacity))"
    registerToggle!.innerText = "Kirjaudutko?"
    loginButton!.style.display = "none"
    registerButton!.style.display = "block"
  } else {
    names!.style.display = "none"
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
