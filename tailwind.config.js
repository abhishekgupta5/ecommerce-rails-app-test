module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  plugins:[
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/forms')
  ]
}
