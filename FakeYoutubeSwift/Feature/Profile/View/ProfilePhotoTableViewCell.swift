import Foundation
import UIKit

class ProfilePhotoTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let photoView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        return view
    }()
    
    // MARK: - Constructors
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions
extension ProfilePhotoTableViewCell {
    func config(url: URL) {
        photoView.setImage(url: url)
    }
    
    func config(image: UIImage) {
        photoView.image = image
    }
}

// MARK: - UI
extension ProfilePhotoTableViewCell {
    private func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(photoView)
        
        let photoWidth: CGFloat = 100
        
        NSLayoutConstraint.activate([
            photoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoView.widthAnchor.constraint(equalToConstant: photoWidth),
            photoView.heightAnchor.constraint(equalToConstant: photoWidth)
        ])
        
        photoView.layer.cornerRadius = photoWidth * 0.5
    }
}
