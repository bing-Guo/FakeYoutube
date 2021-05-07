import UIKit

class ChannelTableViewCell: UITableViewCell {
    // MARK: - Properties
     let thumbnailImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    let publishedAtLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        
        return label
    }()
    private let stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        
        return view
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    override func prepareForReuse() {
        updateAppearanceFor(nil)
    }
}

// MARK: - Action
extension ChannelTableViewCell {
    func config(title: String, publishedAt: String, imageURL: URL) {
        titleLabel.text = title
        publishedAtLabel.text = publishedAt
        
        loadingIndicator.startAnimating()
        
        if let cachedImage = ImageCache.shared.getCache().object(forKey: imageURL as NSURL) {
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.thumbnailImageView.image = cachedImage
            }
        } else {
            Downloader().downloadImage(url: imageURL) { [weak self] cachedImage in
                DispatchQueue.main.async {
                    self?.loadingIndicator.stopAnimating()
                    self?.thumbnailImageView.image = cachedImage
                }
            }
        }
    }
    
    func updateAppearanceFor(_ image: UIImage?) {
        loadingIndicator.startAnimating()
        
        DispatchQueue.main.async {
            self.displayImage(image)
        }
    }
    
    private func displayImage(_ image: UIImage?) {
        if let _image = image {
            thumbnailImageView.image = _image
            loadingIndicator.stopAnimating()
        } else {
            loadingIndicator.startAnimating()
            thumbnailImageView.image = .none
        }
    }
}

// MARK: - UI
extension ChannelTableViewCell {
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .white
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(publishedAtLabel)
        
        contentView.addSubview(loadingIndicator)
        contentView.addSubview(stackView)
        contentView.addSubview(thumbnailImageView)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            thumbnailImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 180),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            loadingIndicator.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor)
        ])
    }
}
