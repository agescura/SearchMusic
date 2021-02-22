//
//  MessageTableViewCell.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 21/2/21.
//

import SnapKit
import UIKit

class MessageTableViewCell: UITableViewCell {
    
    // MARK: Outlets

    private let messageLabel = Label(with: .systemFont(ofSize: 16), textColor: .red)

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
        
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        messageLabel.text = "Unknown error"
    }
}
