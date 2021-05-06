import Foundation

class VideoTableViewModel {
    // MARK: - Properties
    let item: PlaylistItem
    var data: Any? {
        didSet {
            dataDidChangedClosure?(data)
        }
    }
    
    // MARK: - Closures
    var dataDidChangedClosure: ((Any?) -> Void)?
    
    // MARK: - Constructors
    init(item: PlaylistItem) {
        self.item = item
    }
}
