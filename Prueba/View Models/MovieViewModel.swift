//
//  MovieViewModel.swift
//  Prueba
//
//  Created by Thomas Fauquemberg on 06/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

struct MovieViewModel {
    
    let infoText: NSAttributedString
    let imageName: String
    
    init(title: String, description: String, imageName: String) {
        
        let attributedString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
        
        attributedString.append(NSAttributedString(string: "\n\(description)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
       infoText = attributedString
       self.imageName = imageName
    }
    
    
}
