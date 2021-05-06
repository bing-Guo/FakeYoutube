import UIKit

class ChannelTableViewController: UIViewController {
    // MARK: - Properties
    let viewModel = ChannelTableViewModel()
    
    private let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    // MARK: - Constructors
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        
        viewModel.update()
    }
}

// MARK: - UI
extension ChannelTableViewController {
    private func setupUI() {
        setupNavigation()
        setupTableView()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "床編故事 Bad Time Stories"
    }
    
    private func setupTableView() {
        tableView.register(ChannelTableViewCell.self, forCellReuseIdentifier: String(describing: ChannelTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
        
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
}

// MARK: - Data Binding
extension ChannelTableViewController {
    private func setupBinding() {
        viewModel.dataDidChangedClosure = { [tableView] _ in
            DispatchQueue.main.async { [tableView] in
                tableView.reloadData()
            }
        }
        
        viewModel.errorOccurredClosure = { message in
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "確認", style: .default, handler: nil)
                alertController.addAction(confirmAction)
            
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        viewModel.isLoading = { [spinner] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    spinner.startAnimating()
                } else {
                    spinner.stopAnimating()
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ChannelTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChannelTableViewCell.self), for: indexPath) as? ChannelTableViewCell else {
            return UITableViewCell()
        }
        
        if let data = viewModel.sections?[indexPath.row] {
            cell.config(title: data.snippet.title,
                        publishedAt: data.snippet.publishedAt,
                        imageURL: URL(string: data.snippet.thumbnails.medium.url)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = self.viewModel.sections?[indexPath.row] {
            let viewModel = VideoTableViewModel(item: data)
            let viewController = VideoTableViewController(viewModel: viewModel)
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let isBottomOfTable = (indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)
        
        if isBottomOfTable {
            viewModel.update()
        }
    }
}

extension ChannelTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections?.count ?? 0
    }
}
