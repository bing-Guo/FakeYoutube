# 目的
練習MVVM(Closure), UITableView Prefetching, Cache

有三個Tab
* Profile直接忽略
* Normal為沒有用Prefetching，在cellForRowAt綁定UI
* Prefetch為有用Prefetching，在willDisplay綁定UI

# 差異
此案例單純download image看不太出兩者差異，可以模擬時間延遲，可以在位置（Infrastructure/Cache/Downloader.swift）解開asyncAfter的註解進行模擬。

# 注意
ApplicationKey需要自行帶入
1. 位置：Infrastructure/Networking/YoutubeAPI/YoutubeAPIManager.swift
2. 取得方式：自行申請 https://console.developers.google.com/flows/enableapi?apiid=youtube&pli=1 or 認識的人請私我 😂


