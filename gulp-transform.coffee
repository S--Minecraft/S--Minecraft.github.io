Transform = {}
###
  Works
###
# arr1とarr2を重複なしでconcatする
noDuplicateConcat = (arr1, arr2) ->
  for n in arr2
    flag = true
    for m in arr1
      if n is m
        flag = false
        break
    if flag then arr1.push(n)
  return arr1

makeAllTag = (obj) ->
  allTag = []
  for w in obj.works
    allTag = noDuplicateConcat(allTag, w.tags)
  allTag.some( (v, i) ->
    if v is "Other" then allTag.splice(i, 1)
    return
  )
  allTag.sort()
  return allTag

tagToString = (obj) ->
  for w in obj.works
    w.tags = w.tags.sort().reverse()
    w.tagsStr = w.tags.join(" ")
  return obj

Transform.works = (obj) ->
  obj.allTag = makeAllTag(obj)
  obj = tagToString(obj)
  return obj

module.exports = (obj) ->
  obj = Transform.works(obj)
  return obj
