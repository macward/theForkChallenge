//
//  RestaurantTableViewCell.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import UIKit

protocol RestaurantCellDelegate {
    func favorite(_ restaurant: Restaurant)
}

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    var delegate: RestaurantCellDelegate?
    private var restaurant: Restaurant!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ restaurant: Restaurant, isFav: Bool = false) {
        self.restaurant = restaurant
        self.nameLabel.text = restaurant.name
        self.addressLabel.text = restaurant.address
        self.ratingLabel.text = "\(restaurant.rating)"
        favButton.imageView?.image = isFav ? UIImage(named: "filled-heart") : UIImage(named: "empty-heart")
        Task {
            await self.cellImage.loadImageFromUrl(urlString: restaurant.imageUrl, placeholder: "placeholder-image")
        }
    }
    
    @IBAction func didTapFavButton(_ sender: UIButton) {
        self.delegate?.favorite(self.restaurant)
    }
}
