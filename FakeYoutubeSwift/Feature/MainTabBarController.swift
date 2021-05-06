import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let channelController = UINavigationController(rootViewController: ChannelTableViewController())
        channelController.tabBarItem.image = UIImage(named: "audiotrack")
        channelController.title = "Normal"
        
        let channelWithPrefetchController = UINavigationController(rootViewController: ChannelWithPrefetchTableViewController())
        channelWithPrefetchController.tabBarItem.image = UIImage(named: "music")
        channelWithPrefetchController.title = "Prefetch"
        
        let profileController = UINavigationController(rootViewController: ProfileTableViewController())
        profileController.tabBarItem.image = UIImage(named: "person")
        profileController.title = "Profile"
        
        viewControllers = [profileController, channelController, channelWithPrefetchController]
    }
}
