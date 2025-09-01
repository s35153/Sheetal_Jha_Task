//
//  PortfolioSummaryView.swift
//  Sheetal_Jha_Task
//
//  Created by Sheetal Jha on 31/08/25.
//

import UIKit

class PortfolioSummaryView: UIView {
    
    // MARK: - Properties
    private var isExpanded = false
    private var onToggle: (() -> Void)?
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Portfolio Summary"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alpha = 0
        stackView.isHidden = true
        return stackView
    }()
    
    private let currentValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let investmentValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalPnLLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todaysPnLLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var detailsHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(detailsStackView)
        
        // Header components
        headerView.addSubview(titleLabel)
        headerView.addSubview(arrowImageView)
        
        // Details components
        let currentValueRow = createInfoRow(title: "Current Value", valueLabel: currentValueLabel)
        let investmentValueRow = createInfoRow(title: "Investment Value", valueLabel: investmentValueLabel)
        let totalPnLRow = createInfoRow(title: "Total P&L", valueLabel: totalPnLLabel)
        let todaysPnLRow = createInfoRow(title: "Today's P&L", valueLabel: todaysPnLLabel)
        
        detailsStackView.addArrangedSubview(currentValueRow)
        detailsStackView.addArrangedSubview(investmentValueRow)
        detailsStackView.addArrangedSubview(totalPnLRow)
        detailsStackView.addArrangedSubview(todaysPnLRow)
        
        setupConstraints()
    }
    
    private func createInfoRow(title: String, valueLabel: UILabel) -> UIView {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .secondaryLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.textAlignment = .right
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 16),
            
            containerView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return containerView
    }
    
    private func setupConstraints() {
        detailsHeightConstraint = detailsStackView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            // Container view
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            // Header view
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            // Title label
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // Arrow image view
            arrowImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // Details stack view
            detailsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            detailsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            detailsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            detailsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            detailsHeightConstraint
        ])
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        headerView.addGestureRecognizer(tapGesture)
        headerView.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    @objc private func headerTapped() {
        toggleExpansion()
    }
    
    private func toggleExpansion() {
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.3) {
            // Rotate arrow
            let rotation = self.isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
            self.arrowImageView.transform = rotation
            
            // Show/hide details
            if self.isExpanded {
                self.detailsStackView.isHidden = false
                self.detailsStackView.alpha = 1
                self.detailsHeightConstraint.isActive = false
            } else {
                self.detailsStackView.alpha = 0
                self.detailsHeightConstraint.isActive = true
            }
            
            self.layoutIfNeeded()
        } completion: { _ in
            if !self.isExpanded {
                self.detailsStackView.isHidden = true
            }
        }
        
        onToggle?()
    }
    
    // MARK: - Configuration
    func configure(with portfolio: PortfolioSummary, onToggle: @escaping () -> Void) {
        self.onToggle = onToggle
        
        currentValueLabel.text = "₹\(String(format: "%.2f", portfolio.totalCurrentValue))"
        investmentValueLabel.text = "₹\(String(format: "%.2f", portfolio.totalInvestmentValue))"
        
        let totalPnL = portfolio.totalPnL
        let todaysPnL = portfolio.todaysTotalPnL
        
        // Configure Total P&L colors
        if totalPnL > 0 {
            totalPnLLabel.textColor = .systemGreen
            totalPnLLabel.text = "+₹\(String(format: "%.2f", totalPnL))"
        } else if totalPnL < 0 {
            totalPnLLabel.textColor = .systemRed
            totalPnLLabel.text = "-₹\(String(format: "%.2f", abs(totalPnL)))"
        } else {
            totalPnLLabel.textColor = .label
            totalPnLLabel.text = "₹0.00"
        }
        
        // Configure Today's P&L colors
        if todaysPnL > 0 {
            todaysPnLLabel.textColor = .systemGreen
            todaysPnLLabel.text = "+₹\(String(format: "%.2f", todaysPnL))"
        } else if todaysPnL < 0 {
            todaysPnLLabel.textColor = .systemRed
            todaysPnLLabel.text = "-₹\(String(format: "%.2f", abs(todaysPnL)))"
        } else {
            todaysPnLLabel.textColor = .label
            todaysPnLLabel.text = "₹0.00"
        }
    }
}
