import UIKit

class VideoDescriptionTableViewCellTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
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
extension VideoDescriptionTableViewCellTableViewCell {
    func config(description: String) {
        descriptionLabel.text = description
    }
}

// MARK: - UI
extension VideoDescriptionTableViewCellTableViewCell {
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(descriptionLabel)
        
        let space: CGFloat = 16
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (space / 2)),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: space),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: space * -1),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: (space / 2) * -1)
        ])
    }
}
