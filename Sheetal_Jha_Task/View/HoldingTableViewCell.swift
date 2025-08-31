//
//  HoldingTableViewCell.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import UIKit

class HoldingTableViewCell: UITableViewCell {
    
    static let identifier = "HoldingTableViewCell"
    
    // MARK: - UI Components
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ltpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pnlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .systemBackground
        
        // Add subtle background highlight on selection
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .systemGray6
        self.selectedBackgroundView = selectedBackgroundView
        
        contentView.addSubview(symbolLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(ltpLabel)
        contentView.addSubview(pnlLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            symbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            quantityLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 8),
            quantityLabel.leadingAnchor.constraint(equalTo: symbolLabel.leadingAnchor),
            quantityLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            ltpLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            ltpLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ltpLabel.leadingAnchor.constraint(greaterThanOrEqualTo: symbolLabel.trailingAnchor, constant: 16),
            
            pnlLabel.topAnchor.constraint(equalTo: ltpLabel.bottomAnchor, constant: 8),
            pnlLabel.trailingAnchor.constraint(equalTo: ltpLabel.trailingAnchor),
            pnlLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configuration
    func configure(with holding: Holding) {
        symbolLabel.text = holding.symbol
        quantityLabel.text = "NET QTY: \(holding.quantity)"
        ltpLabel.text = "LTP: ₹ \(String(format: "%.2f", holding.ltp))"
        
        // Configure PnL with colors
        let pnl = holding.totalPnL
        
        if pnl > 0 {
            pnlLabel.textColor = .systemGreen
            pnlLabel.text = "P&L: ₹ \(String(format: "%.2f", pnl))"
        } else if pnl < 0 {
            pnlLabel.textColor = .systemRed
            pnlLabel.text = "P&L: -₹ \(String(format: "%.2f", abs(pnl)))"
        } else {
            pnlLabel.textColor = .label
            pnlLabel.text = "P&L: ₹ 0.00"
        }
    }
}
