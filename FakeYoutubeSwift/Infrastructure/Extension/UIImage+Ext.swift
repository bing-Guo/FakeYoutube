import Foundation
import UIKit

extension UIImageView {
    func setImage(url: URL) {
        Downloader().downloadImage(url: url) { image in
            print("Download: \(url)")
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
