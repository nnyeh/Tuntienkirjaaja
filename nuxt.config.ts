export default defineNuxtConfig({

  modules: [
    '@sidebase/nuxt-auth',
    '@nuxtjs/tailwindcss',
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
