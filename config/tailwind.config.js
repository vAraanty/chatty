module.exports = {
  important: true,
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './config/locales/*.yml'
  ],
  plugins: [],
  corePlugins: {
    preflight: false,
  }
}
