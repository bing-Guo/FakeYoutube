import Foundation
import UIKit

extension UIImageView {
    func setImage(url: URL) {
        Downloader().downloadImage(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
