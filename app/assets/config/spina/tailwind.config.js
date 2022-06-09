module.exports = {
  content: [
    '/home/buhrmi/.rbenv/versions/3.0.2/lib/ruby/gems/3.0.0/gems/spina-2.10.0/app/views/**/*.*',
'/home/buhrmi/.rbenv/versions/3.0.2/lib/ruby/gems/3.0.0/gems/spina-2.10.0/app/components/**/*.*',
'/home/buhrmi/.rbenv/versions/3.0.2/lib/ruby/gems/3.0.0/gems/spina-2.10.0/app/helpers/**/*.*',
'/home/buhrmi/.rbenv/versions/3.0.2/lib/ruby/gems/3.0.0/gems/spina-2.10.0/app/assets/javascripts/**/*.js',
'/home/buhrmi/.rbenv/versions/3.0.2/lib/ruby/gems/3.0.0/gems/spina-2.10.0/app/**/application.tailwind.css'
  ],  
  theme: {
    fontFamily: {
      body: ['Metropolis'],
      mono: ['ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', "Liberation Mono", "Courier New", 'monospace']
    },
    extend: {
      colors: {
        spina: {
          light: '#797ab8',
          DEFAULT: '#6865b4',
          dark: '#3a3a70'
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
