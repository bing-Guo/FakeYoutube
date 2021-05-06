import Foundation
import UIKit

class Downloader {
    func downloadImage(url: URL, completed: @escaping (UIImage?) -> ()) {
//        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.getCache().setObject(image, forKey: url as NSURL)
                    
                    completed(image)
                }
            }.resume()
//        }
    }
}
