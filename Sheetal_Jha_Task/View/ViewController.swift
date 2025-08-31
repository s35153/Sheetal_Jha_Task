//
//  ViewController.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var portfolioSummaryView: PortfolioSummaryView = {
        let view = PortfolioSummaryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.showsVerticalScrollIndicator = true
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Data
    private var portfolioSummary: PortfolioSummary?
    
    // MARK: - ViewModel
    private let viewModel: HoldingsViewModelProtocol
    
    // MARK: - Initialization
    init(viewModel: HoldingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigationBar()
        setupTableView()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Holdings"
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        // Add styling to navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        view.addSubview(portfolioSummaryView)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            // Portfolio Summary View
            portfolioSummaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            portfolioSummaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            portfolioSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Table View
            tableView.topAnchor.constraint(equalTo: portfolioSummaryView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Activity Indicator
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Register custom cell
        tableView.register(HoldingTableViewCell.self, forCellReuseIdentifier: HoldingTableViewCell.identifier)
    }
    
    private func loadData() {
        activityIndicator.startAnimating()
        
        // Set up callbacks
        if let holdingsViewModel = viewModel as? HoldingsViewModel {
            holdingsViewModel.onDataLoaded = { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.updatePortfolioSummary()
                self?.tableView.reloadData()
            }
            
            holdingsViewModel.onError = { [weak self] error in
                self?.activityIndicator.stopAnimating()
                self?.showError(error)
            }
        }
        
        viewModel.loadHoldings()
    }
    
    private func updatePortfolioSummary() {
        // Create holdings array from viewModel
        var holdings: [Holding] = []
        for i in 0..<viewModel.numberOfHoldings {
            holdings.append(viewModel.holding(at: i))
        }
        
        // Create portfolio summary
        portfolioSummary = PortfolioSummary(holdings: holdings)
        
        // Configure the summary view
        if let summary = portfolioSummary {
            portfolioSummaryView.configure(with: summary) { [weak self] in
                // Handle expand/collapse animation
                UIView.animate(withDuration: 0.3) {
                    self?.view.layoutIfNeeded()
                }
            }
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfHoldings
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HoldingTableViewCell.identifier, for: indexPath) as? HoldingTableViewCell else {
            return UITableViewCell()
        }
        
        let holding = viewModel.holding(at: indexPath.row)
        cell.configure(with: holding)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
