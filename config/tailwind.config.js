module.exports = {
  important: true,
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './config/locales/*.yml',
    './config/initializers/constants.rb'
  ],
  plugins: [],
  corePlugins: {
    preflight: false,
  }
}
