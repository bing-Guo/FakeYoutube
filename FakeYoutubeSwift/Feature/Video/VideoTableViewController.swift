import UIKit

class VideoTableViewController: UIViewController {
    // MARK: - Section
    private enum Section: Int, CaseIterable {
        case headerImage
        case title
        case description
        
        var reuseIdentifier: String {
            switch self {
            case .headerImage:
                return "headerImageCellIdentifier"
            case .title:
                return "titleCellIdentifier"
            case .description:
                return "descriptionIdentifier"
            }
        }
    }
    
    // MARK: - Properties
    let viewModel: VideoTableViewModel
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - Constructors
    init(viewModel: VideoTableViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI
extension VideoTableViewController {
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(VideoHeaderImageTableViewCellTableViewCell.self, forCellReuseIdentifier: Section.headerImage.reuseIdentifier)
        tableView.register(VideoTitleTableViewCellTableViewCell.self, forCellReuseIdentifier: Section.title.reuseIdentifier)
        tableView.register(VideoDescriptionTableViewCellTableViewCell.self, forCellReuseIdentifier: Section.description.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension VideoTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .headerImage:
            return 1
        case .title:
            return 1
        case .description:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .headerImage:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Section.headerImage.reuseIdentifier, for: indexPath) as? VideoHeaderImageTableViewCellTableViewCell else {
                return UITableViewCell()
            }
            
            let url = URL(string: viewModel.item.snippet.thumbnails.standard.url)!
            cell.config(url: url)
            
            return cell
            
        case .title:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Section.title.reuseIdentifier, for: indexPath) as? VideoTitleTableViewCellTableViewCell else {
                return UITableViewCell()
            }
            
            cell.config(title: viewModel.item.snippet.title, publishedAt: viewModel.item.snippet.publishedAt)
            
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Section.description.reuseIdentifier, for: indexPath) as? VideoDescriptionTableViewCellTableViewCell else {
                return UITableViewCell()
            }
            
            cell.config(description: viewModel.item.snippet.snippetDescription)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
