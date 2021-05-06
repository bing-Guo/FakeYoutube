import UIKit

class VideoHeaderImageTableViewCellTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let headerImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        
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
extension VideoHeaderImageTableViewCellTableViewCell {
    func config(url: URL) {
        headerImageView.setImage(url: url)
    }
}

// MARK: - UI
extension VideoHeaderImageTableViewCellTableViewCell {
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(headerImageView)
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
