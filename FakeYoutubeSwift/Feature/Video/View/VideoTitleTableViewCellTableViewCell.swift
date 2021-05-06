import UIKit

class VideoTitleTableViewCellTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private let publishedAtLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        
        return label
    }()
    private let containerStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        
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
extension VideoTitleTableViewCellTableViewCell {
    func config(title: String, publishedAt: String) {
        titleLabel.text = title
        publishedAtLabel.text = publishedAt
    }
}

// MARK: - UI
extension VideoTitleTableViewCellTableViewCell {
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(publishedAtLabel)
        
        let space: CGFloat = 16
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (space / 2)),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: space),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: space * -1),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: (space / 2) * -1)
        ])
    }
}
