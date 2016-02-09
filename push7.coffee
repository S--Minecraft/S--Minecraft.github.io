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
  新しい記事の名前などを返す
  [1]にmdのパス(拡張子含む)
  [2]にhtmlのパス(拡張子除く)
###
getNewRegEx = ->
  newFileNameRaw = execSync("git status | grep -G "new file:.*\"hugo/content/.*\.md\"")
  newFileNameRegEx = newFileNameRaw.match(/new file:.*"(hugo/content/(.*)\.md)\"/)
  return newFileNameRegEx

###
  mdからtitleを抽出
###
getTitle = (fileName) ->
  title = fs.readFileSync(fileName).match(/---(?:\n|.)*title: "(.*?)"(?:\n|.)*---/)[1]
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
    )
    return
  )
  req.on("error", (e) ->
    console.log "Errored on requesting: #{e.message}"
  )
  req.write(JSON.stringify(cfg))
  req.end()
  return

cfg.apiKey = process.env.apiKey
newFileNameRegEx = getNewRegEx()
cfg.body = getTitle(newFileNameRegEx[1])
cfg.url += newFileNameRegEx[2]
post(cfg)
