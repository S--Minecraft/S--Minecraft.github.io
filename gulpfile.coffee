exec = require("child_process").exec
gulp = require "gulp"
del = require "del"
notify = require "gulp-notify"
plumber = require "gulp-plumber"
changed = require "gulp-changed"
coffee = require "gulp-coffee"
sass = require "gulp-sass"
haml = require "gulp-haml"
bower = require "main-bower-files"
uglify = require "gulp-uglify"
htmlmin = require "gulp-htmlmin"
cssnano = require "gulp-cssnano"
inlineSource = require "gulp-inline-source"
replace = require "gulp-replace"

tasks = ["coffee", "haml", "scss", "icons", "img", "lib"]
gulp.task "default", tasks

gulp.task "hugo", ["hugo-run"]

rtasks = ["js-min", "html-min", "css-min", "r-icons", "r-img", "r-lib"]
gulp.task "release", rtasks

gulp.task "clean", (cb) ->
  return del ["./bin/**", "./release/**", "./hugo/publish/**"], cb

gulp.task "watch", ["default"], ->
  gulp.watch "./src/**/*.coffee", ["coffee"]
  gulp.watch "./src/**/*.haml", ["haml"]
  gulp.watch "./src/**/*.scss", ["scss"]
  gulp.watch "./src/css/icons/*.svg", ["icons"]
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
    .pipe(haml({ compiler: "visionmedia" }))
    .pipe(gulp.dest("./bin"))

gulp.task "scss", ->
  return gulp.src "./src/**/*.scss"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin"))
    .pipe(sass())
    .pipe(gulp.dest("./bin"))

gulp.task "icons", ->
  return gulp.src "./src/css/icons/**/*.svg"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin/css/icons"))
    .pipe(gulp.dest("./bin/css/icons"))

gulp.task "img", ->
  return gulp.src "./src/img/**"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin/img"))
    .pipe(gulp.dest("./bin/img"))

gulp.task "lib-bower", ->
  return gulp.src(bower())
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin/lib"))
    .pipe(gulp.dest("./bin/lib"))

gulp.task "lib-copy", ->
  return gulp.src "./src/lib/**"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed("./bin/lib"))
    .pipe(gulp.dest("./bin/lib"))

gulp.task "hugo-set", ["haml"], ->
  return gulp.src "./bin/blog/**"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(replace("|~~", "{{"))
    .pipe(replace("~~|", "}}"))
    .pipe(replace("~~", '"'))
    .pipe(changed("./hugo/layouts"))
    .pipe(gulp.dest("./hugo/layouts"))

gulp.task "hugo-run", ["hugo-set"], (cb) ->
  exec("cd hugo&&hugo", (err, stdout, stderr) ->
    console.log stdout
    console.log stderr
    cb(err)
    return
  )
  return

gulp.task "lib", ["lib-bower", "lib-copy"]

gulp.task "js-min", ["coffee"], ->
  return gulp.src "./bin/js/**/*.js"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(uglify())
    .pipe(gulp.dest("./release/js"))

gulp.task "html-in", ["haml"], ->
  return gulp.src ["./bin/404.html", "./bin/500.html", "./bin/503.html"]
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(inlineSource())
    .pipe(htmlmin({collapseWhitespace: true}))
    .pipe(gulp.dest("./release"))

gulp.task "hugo-copy", ["hugo"], ->
  return gulp.src "./hugo/public/**"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(gulp.dest("./release/blog"))

gulp.task "html-min", ["html-in", "hugo-copy"], ->
  return gulp.src ["./bin/**/*.html", "!./bin/404.html", "!./bin/500.html", "!./bin/503.html", "!./bin/blog/**"]
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(htmlmin({collapseWhitespace: true}))
    .pipe(gulp.dest("./release"))

gulp.task "css-min", ["scss"], ->
  return gulp.src "./bin/css/**/*.css"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(cssnano())
    .pipe(gulp.dest("./release/css"))

gulp.task "r-icons", ["icons"], ->
  return gulp.src "./bin/css/icons/**"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(gulp.dest("./release/css/icons"))

gulp.task "r-img", ["img"], ->
  return gulp.src "./bin/img/**"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(gulp.dest("./release/img"))

gulp.task "r-lib", ["lib"], ->
  return gulp.src "./bin/lib/**"
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(gulp.dest("./release/lib"))
