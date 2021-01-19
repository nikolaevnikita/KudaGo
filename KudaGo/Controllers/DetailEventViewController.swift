//
//  DetailEventViewController.swift
//  KudaGo
//
//  Created by Николаев Никита on 15.01.2021.
//

import UIKit

class DetailEventViewController: UIViewController {
    var event: Event?

    @IBOutlet weak var imageView: LoadedImageView!
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
        
        guard let imageURLString = event.images?.first?.image,
              let imageURL = URL(string: imageURLString) else { return }
        imageView.loadImage(from: imageURL)
        
    }
}
