//
//  SearchTableViewCell.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import SnapKit
import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - ViewModel
    
    var viewModel: SearchViewModel! {
        didSet { bind() }
    }
    
    // MARK: Outlets

    private let verticalStackView = StackView()
    private let horizontalStackView = StackView(with: .horizontal)
    private let titleLabel = Label(with: .boldSystemFont(ofSize: 18), textColor: .black, numberOfLines: 0)
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
        
        horizontalStackView.addArrangedSubviews([countryLabel, yearLabel])
        verticalStackView.addArrangedSubviews([titleLabel,
                                               genreLabel,
                                               horizontalStackView])
        contentView.addSubview(verticalStackView)
            
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }

    // MARK: Private Methods
    
    private func bind() {
        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.subtitle
        countryLabel.text = viewModel.leftText
        yearLabel.text = viewModel.rightText
    }
}

