gulp = require "gulp"
del = require "del"
notify = require "gulp-notify"
plumber = require "gulp-plumber"
changed = require "gulp-changed"
coffee = require "gulp-coffee"
sass = require "gulp-sass"
haml = require "gulp-haml"
bower = require "main-bower-files"

tasks = ["coffee", "haml", "scss", "img", "lib"]
gulp.task "default", tasks

gulp.task "clean", (cb) ->
  return del ["./bin/**"], cb

gulp.task "watch", ["default"], ->
  gulp.watch "./src/**/*.coffee", ["coffee"]
  gulp.watch "./src/**/*.haml", ["haml"]
  gulp.watch "./src/**/*.scss", ["scss"]
  gulp.watch "./src/img/**", ["img"]
  return

# compile
gulp.task "coffee", ->
  return gulp.src "./src/**/*.coffee"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin"))
    .pipe(coffee())
    .pipe(gulp.dest("./bin"))

gulp.task "haml", ->
  return gulp.src "./src/**/*.haml"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin"))
    .pipe(haml())
    .pipe(gulp.dest("./bin"))

gulp.task "scss", ->
  return gulp.src "./src/**/*.scss"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin"))
    .pipe(sass())
    .pipe(gulp.dest("./bin"))

gulp.task "img", ->
  return gulp.src "./src/img/**"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin/img"))
    .pipe(gulp.dest("./bin/img"))

gulp.task "lib", ->
  return gulp.src(bower())
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin/lib"))
    .pipe(gulp.dest("./bin/lib"))
