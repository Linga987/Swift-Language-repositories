//
//  RepoCell.swift
//  iOSAssignment
//
//  Created by Lingaswami Karingula on 01/09/25.
//

import Foundation
import UIKit

/// Custom table view cell for displaying a GitHub repository
/// - Shows the repo name in bold text
/// - Uses MVVM model binding (via `repos` property)
class RepoCell: UITableViewCell {
    
    static let identifier = "RepoCell"
    private let nameLabel = UILabel()
    
    var repos: Items? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Reset cell before reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    
    // MARK: - UI Setup
    func setupUI() {
        contentView.backgroundColor = UIColor(hex: "#24292e")
        
        nameLabel.textColor = UIColor(hex: "#fafbfc")
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -24),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func updateUI() {
        nameLabel.text = repos?.name
    }
    
    /// show shadow efffect around tableview cells
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadowConfiguration()
    }
}
