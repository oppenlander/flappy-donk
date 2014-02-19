gulp = require 'gulp'
gutil = require 'gulp-util'
gulpif = require 'gulp-if'

coffee = require 'gulp-coffee'
browserify = require 'gulp-browserify'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
sass = require 'gulp-sass'
refresh = require 'gulp-livereload'
imagemin = require 'gulp-imagemin'
zip = require 'gulp-zip'
clean = require 'gulp-clean'

connect = require 'connect'
http = require 'http'
path = require 'path'
lr = require 'tiny-lr'
server = lr()

gulp.task 'webserver', ->
  port = 3000
  hostname = null
  base = path.resolve 'dist/site'
  directory = path.resolve 'dist/site'

  app = connect()
    .use(connect.static base)
    .use(connect.directory directory)

  http.createServer(app).listen port, hostname

# Starts the livereload server
gulp.task 'livereload', ->
    server.listen 35729, (err) ->
        console.log err if err?

gulp.task 'vendor', ->
  gulp.src('scripts/vendor/*.js')
      .pipe(concat 'vendor.js')
      .pipe(gulpif gutil.env.production, uglify())
      .pipe(gulp.dest 'dist/site/assets/')
      .pipe(refresh server)

gulp.task 'scripts', ->
  gulp.src('scripts/coffee/game.coffee', { read: false })
      .pipe(browserify({
        transform: ['coffeeify']
        extensions: ['.coffee']
        debug: !gutil.env.production
        }))
      .pipe(concat 'scripts.js')
      .pipe(gulpif gutil.env.production, uglify())
      .pipe(gulp.dest 'dist/site/assets/')
      .pipe(refresh server)

gulp.task 'styles', ->
  gulp.src('styles/scss/init.scss')
      .pipe(sass includePaths: ['styles/scss/includes'])
      .pipe(concat 'styles.css')
      .pipe(gulp.dest 'dist/site/assets/')
      .pipe(refresh server)

gulp.task 'html', ->
  gulp.src('*.html')
      .pipe(gulp.dest 'dist/site/')
      .pipe(refresh server)

gulp.task 'images', ->
  gulp.src('resources/images/**')
      .pipe(gulp.dest 'dist/site/assets/images/')
      .pipe(imagemin())
      .pipe(refresh server)

gulp.task 'sounds', ->
  gulp.src('resources/sounds/**')
      .pipe(gulp.dest('dist/site/assets/sounds/'))
      .pipe(refresh server)

gulp.task 'clean', ->
  gulp.src('dist', read: false)
      .pipe(clean())

gulp.task 'watch', ->
  gulp.watch 'scripts/vendor/**', ['vendor']
  gulp.watch 'scripts/coffee/**', ['scripts']
  gulp.watch 'styles/scss/**', ['styles']
  gulp.watch '*.html', ['html']
  gulp.watch 'resources/images/**', ['images']
  gulp.watch 'resources/sounds/**', ['sounds']

gulp.task 'build', ['scripts', 'styles', 'images', 'sounds', 'vendor', 'html']

gulp.task 'package', ['build'], ->
  gulp.src('dist/site/**')
      .pipe(zip 'archive.zip')
      .pipe(gulp.dest 'dist/')

gulp.task 'default', ['webserver', 'livereload', 'watch', 'build']
