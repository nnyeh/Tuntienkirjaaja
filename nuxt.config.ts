export default defineNuxtConfig({

  modules: [
    '@sidebase/nuxt-auth',
    '@nuxtjs/tailwindcss',
    '@huntersofbook/naive-ui-nuxt',
    'nuxt-icon',
    [
      '@nuxtjs/google-fonts', {
        families: {
          "Poppins": true,
          "Azeret+Mono": true
        }
      }
    ]
  ],

  auth: {
    enableGlobalAppMiddleware: true
  },

  typescript: {
    shim: false
  }

})
