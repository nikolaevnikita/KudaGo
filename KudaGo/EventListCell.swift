//
//  EventListCell.swift
//  KudaGo
//
//  Created by Николаев Никита on 14.01.2021.
//

import UIKit

class EventListCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: LoadedImageView!
    
    private var uuid: UUID?
    
    func setup(by event: Event) {
        imageView.image = nil
        nameLabel.text = event.title?.capitalized
        layer.cornerRadius = Constants.CollectionViewSettings.cellCornerRadius
        guard let imageURLString = event.images?.first?.image,
              let imageURL = URL(string: imageURLString) else { return }
        imageView.loadImage(from: imageURL)
    }
}
