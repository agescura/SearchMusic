//
//  ListTableViewCell.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import SnapKit
import UIKit

class ListTableViewCell: UITableViewCell {
    
    // MARK: - ViewModel
    
    var viewModel: Album! {
        didSet { bind() }
    }
    
    // MARK: Outlets

    private let verticalStackView = StackView()
    private let horizontalStackView = StackView(with: .horizontal)
    private let titleLabel = Label(with: .boldSystemFont(ofSize: 18))
    private let genreLabel = Label(with: .italicSystemFont(ofSize: 14))
    private let countryLabel = Label()
    private let yearLabel = Label()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customInit()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func customInit() {
        selectionStyle = .none
        
        horizontalStackView.addArrangedSubviews([country, year])
        verticalStackView.addArrangedSubviews([title,
                                               genre,
                                               horizontalStackView])
        contentView.addSubview(verticalStackView)
            
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }

    // MARK: Private Methods
    
    private func bind() {
        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        countryLabel.text = viewModel.country
        yearLabel.text = viewModel.year
    }
}
