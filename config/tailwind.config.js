const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Ubuntu", "sans-serif"],
      },
      colors: {
        "primary": "#ffffff",
        "secondary": "#f9fafb",
        "ink": "#111827",
        "gigas": "#4c44ad",
        "bluebell": "#9697c4",
        "linkwater": "#ebeef8",
        "apricot": "#ee896c",
        "turquoise": "#36e0ca",
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
