
/** @type {import('tailwindcss').Config} */
module.exports = {
  important: true,
  variants: {
    extend: {
      cursor: ['disabled'],
      pointerEvents: ['disabled'],
      backgroundColor: ['disabled']
    }
  },
  content: [],
  theme: {
    extend: {
      fontFamily: {
        "sans": ["Poppins"],
        "mono": ['"Azeret Mono"']
      }
    }
  },
  plugins: []
}
