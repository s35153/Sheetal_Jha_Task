//
//  ViewController.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.showsVerticalScrollIndicator = true
        return tableView
    }()
    
    // MARK: - Data
    private var holdings: [Holding] = []
    private var portfolioSummary: PortfolioSummary?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigationBar()
        setupTableView()
        loadMockData()
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
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            // Table View
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Register custom cell
        tableView.register(HoldingTableViewCell.self, forCellReuseIdentifier: HoldingTableViewCell.identifier)
    }
    
    private func loadMockData() {
        holdings = [
            Holding(symbol: "ASHOKLEY", quantity: 3, ltp: 119.10, avgPrice: 115.80, close: 118.50),
            Holding(symbol: "HDFC", quantity: 7, ltp: 2497.20, avgPrice: 2714.06, close: 2485.30),
            Holding(symbol: "ICICIBANK", quantity: 1, ltp: 624.70, avgPrice: 489.10, close: 620.15),
            Holding(symbol: "IDEA", quantity: 3, ltp: 9.95, avgPrice: 9.02, close: 9.85),
            Holding(symbol: "MARICO", quantity: 12, ltp: 653.45, avgPrice: 578.50, close: 645.10),
            Holding(symbol: "VBL", quantity: 1, ltp: 1033.85, avgPrice: 1054.70, close: 1028.20),
            Holding(symbol: "KPITTECH", quantity: 25, ltp: 1667.55, avgPrice: 1640.75, close: 1656.90),
            Holding(symbol: "BHARTIARTL", quantity: 8, ltp: 1222.50, avgPrice: 1201.35, close: 1215.80),
            Holding(symbol: "TATACONSUM", quantity: 15, ltp: 912.80, avgPrice: 923.45, close: 905.60),
            Holding(symbol: "RELIANCE", quantity: 5, ltp: 2845.30, avgPrice: 2780.20, close: 2832.15),
            Holding(symbol: "TCS", quantity: 3, ltp: 4123.75, avgPrice: 4089.60, close: 4110.25),
            Holding(symbol: "INFY", quantity: 7, ltp: 1834.20, avgPrice: 1798.45, close: 1821.90),
            Holding(symbol: "WIPRO", quantity: 20, ltp: 445.60, avgPrice: 461.80, close: 442.15),
            Holding(symbol: "HCLTECH", quantity: 6, ltp: 1598.35, avgPrice: 1612.90, close: 1591.20)
        ]
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holdings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HoldingTableViewCell.identifier, for: indexPath) as? HoldingTableViewCell else {
            return UITableViewCell()
        }
        
        let holding = holdings[indexPath.row]
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

