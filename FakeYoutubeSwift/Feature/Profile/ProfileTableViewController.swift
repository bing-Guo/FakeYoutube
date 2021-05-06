import UIKit

class ProfileTableViewController: UIViewController {
    // MARK: - Section
    private enum Section: Int, CaseIterable {
        case normal
        case description
        
        var reuseIdentifier: String {
            switch self {
            case .normal:
                return "normalCellIdentifier"
            case .description:
                return "descriptionIdentifier"
            }
        }
    }
    
    // MARK: - Properties
    let viewModel = ProfileTableViewModel()
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - Constructors
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI
extension ProfileTableViewController {
    private func setupUI() {
        setupNavigation()
        setupTableView()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = viewModel.author
    }
    
    private func setupTableView() {
        tableView.register(ProfilePhotoTableViewCell.self, forCellReuseIdentifier: Section.normal.reuseIdentifier)
        tableView.register(ProfileDescriptionTableViewCell.self, forCellReuseIdentifier: Section.description.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ProfileTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .normal:
            return 1
        case .description:
            return viewModel.decriptionSections.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .normal:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Section.normal.reuseIdentifier, for: indexPath) as? ProfilePhotoTableViewCell else {
                return UITableViewCell()
            }
            
            cell.config(image: UIImage(named: "chicken")!)
            
            return cell
            
        case .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Section.description.reuseIdentifier, for: indexPath) as? ProfileDescriptionTableViewCell else {
                return UITableViewCell()
            }
            
            let data = viewModel.decriptionSections[indexPath.row]
            cell.config(title: data.title, description: data.description)
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section(rawValue: indexPath.section) {
        case .normal:
            return 200
        case .description:
            return 48
        default:
            return 0
        }
    }
}
