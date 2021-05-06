import Foundation

class ChannelWithPrefetchTableViewModel {
    // MARK: - Properties
    let playListID = "UUaVICnDUyoEnGvk0W38Rtyg"
    let defaultMaxCount: Int = 20
    
    var images: [ImageModel] = [ImageModel]()
    var sections: [PlaylistItem]? {
        didSet {
            dataDidChangedClosure?(sections)
        }
    }
    lazy var loadingQueue = OperationQueue()
    lazy var loadingOperations = [IndexPath : DataLoadOperation]()
    
    private var nextPageToken: String?
    private var totalResult: Int?
    private var isLastPage: Bool {
        if let current = sections?.count, let total = totalResult, total == current {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Closures
    var dataDidChangedClosure: (([PlaylistItem]?) -> Void)?
    var errorOccurredClosure: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?
    
    // MARK: - Constructors
    init() {
        self.sections = []
        
        loadingQueue.maxConcurrentOperationCount = -1
    }
    
    func loadImage(at index: Int) -> DataLoadOperation? {
        if (0..<images.count).contains(index) {
            return DataLoadOperation(images[index])
        }
        return .none
    }
    
    func update() {
        guard !isLastPage else {
            return
        }
        
        fetchPlaylistItemList()
    }
    
    private func fetchPlaylistItemList() {
        isLoading?(true)
        
        YoutubeAPIManager.shared.fetchPlaylistItemList(playListID: playListID, maxCount: defaultMaxCount, pageToken: nextPageToken) { [weak self] result in
            switch result {
            case let .success(response):
                self?.sections?.append(contentsOf: response.items)
                self?.nextPageToken = response.nextPageToken
                self?.totalResult = response.pageInfo.totalResults
                
                let thumbnailsImages = response.items.map {
                    ImageModel(url: URL(string: $0.snippet.thumbnails.medium.url))
                }
                self?.images.append(contentsOf: thumbnailsImages)
            case let .failure(error):
                self?.errorOccurredClosure?("載入資料異常\nError: \(String(describing: error))")
            }
            
            self?.isLoading?(false)
        }
    }
}
