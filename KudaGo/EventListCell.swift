//
//  EventListCell.swift
//  KudaGo
//
//  Created by Николаев Никита on 14.01.2021.
//

import UIKit

class EventListCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private var uuid: UUID?
    
    func setup(by event: Event) {
        let currentUUID = UUID()
        uuid = currentUUID
        imageView.image = nil
        nameLabel.text = event.title?.capitalized
        layer.cornerRadius = Constants.CollectionViewSettings.cellCornerRadius
        guard let imageURLString = event.images?.first?.image else { return }
        DispatchQueue.global().async {
            let image = ImageLoadingManager.shared.getImageFromURL(urlString: imageURLString)
            //Check for cell was reused
            if self.uuid != currentUUID {
                return
            }
            DispatchQueue.main.async {
                self.imageView.alpha = 0
                self.imageView.image = image
                UIView.animate(withDuration: 1,
                               delay: 0,
                               options: .curveEaseIn,
                               animations: { self.imageView.alpha = 1 } )
            }
        }
    }
    
}
