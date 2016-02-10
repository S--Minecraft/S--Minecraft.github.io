execSync = require("child_process").execSync
fs = require "fs"
http = require "http"

appNo = "78bcf0e8be4e4912831e529deae1ac2a"
cfg = {
  title: "s.4na.xyz"
  body: "" #記事名
  icon: "https://s.4na.xyz/img/favicon.png"
  url: "https://s.4na.xyz/blog/" #記事url
  apiKey: "" #環境変数apiKey
}
reqHost = "dashboard.push7.jp"
reqPath = "/api/v1/#{appNo}/send"

###
  新しい記事がある
###
getNewRegEx = ->
  status = execSync("git status").toString()
  console.log "-----status-----"
  console.log status
  console.log "----------------"
  return status.match(/new file:.*"?blog\/(?!(?:categories|tags))(.*?\/.*?)\/index\.html"?/)

###
  mdからtitleを抽出
###
getTitle = (fileName) ->
  title = fs.readFileSync(fileName).match(/<title>(.*?) - .*? | .*<\/title>/)[1]
  return title

###
  push7のapiをたたく
###
post = (cfg) ->
  req = http.request({
    hostname: reqHost
    method: "POST"
    path: reqPath
    headers: {
      "Content-Type": "application/json"
    }
  }, (res) ->
    console.log "Request finished with status code: #{res.statusCode}"
    res.setEncoding("utf8")
    res.on("data", (body) ->
      console.log "Response body: #{body}"
      return
    )
    return
  )
  req.on("error", (e) ->
    console.log "Errored on requesting: #{e.message}"
  )
  req.write(JSON.stringify(cfg))
  req.end()
  return

newMatch = getNewRegEx()
console.log "------newMatch------"
console.log newMatch
console.log "--------------------"
if newMatch?
  cfg.apiKey = process.env.apiKey
  newFileName = newMatch[1]
  cfg.body = getTitle("./blog/#{newFileName}/index.html")
  cfg.url += "#{newFileName}/"
  post(cfg)
