import Foundation

class ProfileTableViewModel {
    typealias ProfileDescriptionItem = (title: String, description: String)
    
    // MARK: - Properties
    let author: String
    let decriptionSections: [ProfileDescriptionItem]
    
    // MARK: - Constructors
    init() {
        author = "Bing"
        
        decriptionSections = [
            ProfileDescriptionItem(title: "Github", description: "github.com/bing-Guo"),
            ProfileDescriptionItem(title: "Twitter", description: "@Bing27757298")
        ]
    }
}
