//
//  DetailEventViewController.swift
//  KudaGo
//
//  Created by Николаев Никита on 15.01.2021.
//

import UIKit

class DetailEventViewController: UIViewController {
    var event: Event?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(by: event)
    }
    
    private func setup(by event: Event?) {
        guard let event = event else { return }
        titleLabel.text = event.title?.capitalized
        descriptionTextView.text = event.bodyText
        
        guard let imageURLString = event.images?.first?.image else { return }
        DispatchQueue.global().async {
            let image = ImageLoadingManager.shared.getImageFromURL(urlString: imageURLString)
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
