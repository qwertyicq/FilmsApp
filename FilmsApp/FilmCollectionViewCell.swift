//
//  FilmCollectionViewCell.swift
//  FilmsApp
//
//  Created by Nikolay T on 18.07.2022.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterPreviewImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    init() {
        super.init()
        
        setLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayoutConstraint () {
        self.translatesAutoresizingMaskIntoConstraints = false
        posterPreviewImageView.translatesAutoresizingMaskIntoConstraints = false
        filmTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.heightAnchor.constraint(equalToConstant: 358).isActive = true
        
        NSLayoutConstraint.activate([
            posterPreviewImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            posterPreviewImageView.leadingAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            posterPreviewImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            posterPreviewImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7)])
    }
}
