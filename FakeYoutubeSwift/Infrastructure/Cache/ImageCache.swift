import Foundation
import UIKit

class ImageCache: NSObject {
    private var cache = NSCache<AnyObject, UIImage>()
    public static let shared = ImageCache()
    private override init() {}
   
    func getCache() -> NSCache<AnyObject, UIImage> {
       return cache
    }
}
