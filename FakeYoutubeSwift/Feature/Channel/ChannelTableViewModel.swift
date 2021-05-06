import Foundation

class ChannelTableViewModel {
    // MARK: - Properties
    let playListID = "UUaVICnDUyoEnGvk0W38Rtyg"
    let defaultMaxCount: Int = 20
    
    var sections: [PlaylistItem]? {
        didSet {
            dataDidChangedClosure?(sections)
        }
    }
    
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
                
            case let .failure(error):
                self?.errorOccurredClosure?("載入資料異常\nError: \(String(describing: error))")
            }
            
            self?.isLoading?(false)
        }
    }
}
