import Foundation
import UIKit

class DataLoadOperation: Operation {
    var image: UIImage?
    var loadingCompleteHandler: ((UIImage?) -> ())?
    private var imageModel: ImageModel
    
    init(_ imageModel: ImageModel) {
        self.imageModel = imageModel
    }
    
    override func main() {
        if isCancelled { return }
        
        guard let url = imageModel.url else { return }
        
        downloadImageFrom(url) { [weak self] image in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if self.isCancelled { return }
                
                self.image = image
                self.loadingCompleteHandler?(self.image)
            }
        }
    }
    
    func downloadImageFrom(_ url: URL, completed: @escaping (UIImage?) -> ()) {
        if let cachedImage = ImageCache.shared.getCache().object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                completed(cachedImage)
            }
            return
        }
        
        Downloader().downloadImage(url: url) { image in
            completed(image)
        }
    }
}


