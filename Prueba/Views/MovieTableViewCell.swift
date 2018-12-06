//
//  HomeTableViewCell.swift
//  Prueba
//
//  Created by Thomas Fauquemberg on 06/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movieViewModel: MovieViewModel? {
        didSet {
            if let imageName = movieViewModel?.imageName {
                posterView.image = UIImage(named: imageName)
            }
            if let infos = movieViewModel?.infoText {
                infoLabel.attributedText = infos
            }
        }
    }
    
    fileprivate let posterView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate let infoLabel: UITextView = {
        let tv = UITextView()
        tv.textAlignment = .justified
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
   
    fileprivate func setupLayout() {
        addSubview(posterView)
        posterView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 12, left: 12, bottom: 12, right: 0), size: .init(width: 84, height: 0))
        
        addSubview(infoLabel)
        infoLabel.anchor(top: topAnchor, leading: posterView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 14))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
