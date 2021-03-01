//
//  ImageView.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 1/3/21.
//

import UIKit
import Kingfisher

class ImageView: UIImageView {
    
    var url: String? {
        didSet {
            guard let imageUrl = url,
                  let url = URL(string: imageUrl) else {
                kf.cancelDownloadTask()
                kf.setImage(with: URL(string: ""))
                image = nil
                return
            }
            kf.setImage(with: url)
        }
    }
    
    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
