import Foundation

struct ImageModel {
    private(set) var url: URL?
    
    init(url: URL?) {
        self.url = url
    }
}
