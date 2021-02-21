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
    private let title = Label(with: .boldSystemFont(ofSize: 18))
    private let genre = Label(with: .italicSystemFont(ofSize: 14))
    private let country = Label()
    private let year = Label()

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
        title.text = viewModel.title
        genre.text = viewModel.genre
        country.text = viewModel.country
        year.text = viewModel.year
    }
}
