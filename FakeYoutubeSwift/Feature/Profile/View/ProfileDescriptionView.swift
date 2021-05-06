import Foundation
import UIKit

class ProfileDescriptionTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        
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
extension ProfileDescriptionTableViewCell {
    func config(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}

// MARK: - UI
extension ProfileDescriptionTableViewCell {
    private func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .lightGray
        containerView.layer.cornerRadius = 5
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        let innerSpace: CGFloat = 8
        let outterSpace: CGFloat = 24
        let titleWidth: CGFloat = 100
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: innerSpace),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outterSpace),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: outterSpace * -1),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: innerSpace * -1),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: innerSpace),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: innerSpace),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: innerSpace * -1),
            titleLabel.widthAnchor.constraint(equalToConstant: titleWidth),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: innerSpace),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: innerSpace * -1),
            descriptionLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        ])
    }
}
