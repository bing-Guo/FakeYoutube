import UIKit

extension UITableView {
    func isEndOfTable(_ indexPath: IndexPath) -> Bool {
        let lastSectionIndex = self.numberOfSections - 1
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
        
        return (indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)
    }
}
