# 目的
練習MVVM(Closure), UITableView Prefetching, Cache

有三個Tab
* Profile直接忽略
* Normal為沒有用Prefetching，在cellForRowAt綁定UI
* Prefetch為有用Prefetching，在willDisplay綁定UI

# 使用prefetching好處

prefetching可以預先取得接下來要呈現的indexPaths，你滑的慢一點就是一個[indexPath]，滑得快一點就是多個[indexPath, indexPath, ...] ，好處我們可以把工作量較大、運行時間較長的事情先處理，這類事情把它放在背景執行，所以需要運用到GCD或是NSOperationQueue，讓他去預先下載，下載完放進Cache，這樣呈現之前先確認Cache是否存在，可以加快速度。

cancelPrefetching是當使用者滑太快，中間那些他沒看見的東西，可以取消下載或是降低優先順序，讓資源先放在使用者正在看的資訊上。

大致流程：

1. prefetchRowsAt：確認有沒有正在處理該indexPath的Operation，若有就代表正在處理中，先不管他；若沒有，就要把Operation加入Queue當中。
2. prepareForReuse：先把圖片重置，改成nil
3. cellForRowAt：這裡我把部分靜態資訊直接綁到Cell上，圖片我還是帶nil
4. willDisplayCell：畫面即將呈現，確認該indexPath是否存在Operation，若存在是否已下載完成，若下載完成就呈現，並移除Operation；若還沒下載完成就設定完成後的callback繼續等待；若Operation根本不存在，就加入Queue下載，並設定callback繼續等待。
5. didEndDisplaying：用戶已經離開該cell，但該Operation還在下載，就可以取消了任務了。
6. cancelPrefetchingForRowsAt：同樣邏輯，用戶滑太快，那些中間沒機會呈現的cell，他們的任務也給他取消。

# 注意
## ApplicationKey需要自行帶入
1. 位置：Infrastructure/Networking/YoutubeAPI/YoutubeAPIManager.swift
2. 取得方式：自行申請 https://console.developers.google.com/flows/enableapi?apiid=youtube&pli=1 or 認識的人請私我 😂

## 檢視差異
此案例單純download image看不太出兩者差異，可以模擬時間延遲，可以在位置（Infrastructure/Cache/Downloader.swift）解開asyncAfter的註解進行模擬。

# 困難
1. 究竟要把UI綁定程式寫在willDisplayCell還是cellForRowAt？
網路上有兩派，有人說cellForRowAt是從queue中拿出reuse cell，所以應該要讓他盡快完成，綁定UI這件事情應該要放在willDisplayCell，但有人說根本沒差；[What's New in UICollectionView in iOS 10](https://developer.apple.com/videos/play/wwdc2016/219/)則是說，把較繁重的事情放在cellForRowAt，沒那麼繁重的事情放在willDisplayCell。

2. 要如何客觀的驗證差異？
在模擬網路延遲的情況下，快速滑動Normal版本，是能看到cell在快速替換的跳動感，Prefetch則沒有這種感覺，但還不知道該用哪種Instruments工具去驗證客觀的資訊。

# Reference
1. [What's New in UICollectionView in iOS 10](https://developer.apple.com/videos/play/wwdc2016/219/)
2. [iOS TableView Prefetching DataSource using Swift](https://medium.com/monstar-lab-bangladesh-engineering/tableview-prefetching-datasource-3de593530c4a)

