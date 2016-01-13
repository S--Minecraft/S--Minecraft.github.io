---
categories:
- "site generator"
date: 2016-01-13T20:10:48+09:00
draft: false
tags:
- "hugo"
- "shortcode"
- "ニコ動"
- "haml"
title: "HugoのShortcodeを書いた"
---
いろんなやつ書いてみました  
  
コードはhaml+独自構文で書いてありますが、  
独自構文といっても  
<!--more-->
`|~~ ~~|` は `{{ }}`  
`|~~ ~~|`内の`~~ ~~` は `" "`  
ってことくらいです  
おそらくそんなに意識せずに読めるはず…  
  
すべての使い方は`{{ }}`が全角になってます  
  
## 全般
### ファビコン付きリンク
{{% link "http://www.google.co.jp" "Google"%}}
~~~haml
|~~ $url := .Get 0 ~~|
|~~ $title := .Get 1 ~~|
%a{href: "|~~ $url ~~|"}
  %img{src: "http://favicon.hatena.ne.jp/?url=|~~ $url ~~|", style: "float:left;margin:5px 5px 0px 5px"}
  |~~ $title ~~|
~~~
使い方
~~~
｛｛% link "リンク先" "表示文字列" %｝｝
~~~

## GitHub
{{% link "https://github.com/lepture/github-cards" "GitHub Cards" %}} を利用しているので  
`data-～`の属性をいじくったらいろいろ変えれます  

### レポジトリ
{{% github "S--Minecraft" "ShortQuery.js" %}}
~~~haml
.github-card{"data-user": "|~~ .Get 0 ~~|", "data-repo": "|~~ .Get 1 ~~|", "data-width": 300, "data-theme": "medium", "data-target": "blank"}
%script{src: "//cdn.jsdelivr.net/github-cards/latest/widget.js"}
~~~
使い方
~~~
｛｛% github "S--Minecraft" "ShortQuery.js" %｝｝
~~~
### ユーザー
{{% githubuser "S--Minecraft" %}}
~~~haml
.github-card{"data-user": "|~~ .Get 0 ~~|", "data-width": 300, "data-theme": "medium", "data-target": "blank"}
%script{src: "//cdn.jsdelivr.net/github-cards/latest/widget.js"}
~~~
使い方
~~~
｛｛% githubuser "ユーザー名" %｝｝
~~~

## ニコ動関連
{{% link "http://qiita.com/kounoike/items/cdbfaa2dab9bd3393a84" "Hugoのshortcodesでnicovideoの埋め込みを簡単にする" %}} からのコピペなのでそちらを…

### 動画サムネイル
{{% nicovideo sm9 %}}

### 動画プレイヤー
{{% nicovideoplayer sm9 %}}

## おまけ
Hugoに組み込まれているものを…
コードは {{% link "https://gohugo.io/extras/shortcodes/" "こちら" %}}

### Twitter
{{% tweet 666616452582129664 %}}

### Youtube
{{% youtube w7Ft2ymGmfc %}}

### Vimeo
{{% vimeo 146022717 %}}

### GitHubのgist
{{% gist spf13 7896402 %}}

## ぼそっ
すごい重い記事になりそう…
js入りまくってるだろうし…
