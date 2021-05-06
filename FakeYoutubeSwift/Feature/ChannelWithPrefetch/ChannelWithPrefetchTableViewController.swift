import Foundation
import UIKit

class ChannelWithPrefetchTableViewController: UIViewController {
    // MARK: - Properties
    let viewModel = ChannelWithPrefetchTableViewModel()
    
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
extension ChannelWithPrefetchTableViewController {
    private func setupUI() {
        setupNavigation()
        setupTableView()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Prefetch"
    }
    
    private func setupTableView() {
        tableView.register(ChannelTableViewCell.self, forCellReuseIdentifier: String(describing: ChannelTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
        
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
}

// MARK: - Data Binding
extension ChannelWithPrefetchTableViewController {
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

// MARK: - UITableViewDelegate
extension ChannelWithPrefetchTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ChannelTableViewCell else { return }
        
        if tableView.isEndOfTable(indexPath) {
            viewModel.update()
        }
        
        let updateCellClosure: (UIImage?) -> () = { [viewModel] (image) in
            cell.updateAppearanceFor(image)
            viewModel.loadingOperations.removeValue(forKey: indexPath)
        }
        
        if let dataLoader = viewModel.loadingOperations[indexPath] {
            if let image = dataLoader.image {
                cell.updateAppearanceFor(image)
                viewModel.loadingOperations.removeValue(forKey: indexPath)
            } else {
                dataLoader.loadingCompleteHandler = updateCellClosure
            }
        } else {
            if let dataLoader = viewModel.loadImage(at: indexPath.row) {
                dataLoader.loadingCompleteHandler = updateCellClosure
                viewModel.loadingQueue.addOperation(dataLoader)
                viewModel.loadingOperations[indexPath] = dataLoader
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let dataLoader = viewModel.loadingOperations[indexPath] {
            dataLoader.cancel()
            viewModel.loadingOperations.removeValue(forKey: indexPath)
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ChannelWithPrefetchTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChannelTableViewCell.self), for: indexPath) as? ChannelTableViewCell else {
            return UITableViewCell()
        }
        
        if let data = viewModel.sections?[indexPath.row] {
            cell.titleLabel.text = data.snippet.title
            cell.publishedAtLabel.text = data.snippet.publishedAt
            cell.updateAppearanceFor(nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = viewModel.sections?[indexPath.row] {
            let viewModel = VideoTableViewModel(item: data)
            let viewController = VideoTableViewController(viewModel: viewModel)
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ChannelWithPrefetchTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let _ = viewModel.loadingOperations[indexPath] { return }
            if let dataLoader = viewModel.loadImage(at: indexPath.row) {
                viewModel.loadingQueue.addOperation(dataLoader)
                viewModel.loadingOperations[indexPath] = dataLoader
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let dataLoader = viewModel.loadingOperations[indexPath] {
                dataLoader.cancel()
                viewModel.loadingOperations.removeValue(forKey: indexPath)
            }
        }
    }
}
