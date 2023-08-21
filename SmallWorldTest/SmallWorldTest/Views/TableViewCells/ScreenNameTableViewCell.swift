//
//  ScreenNameTableViewCell.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import UIKit

class ScreenNameTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var data: MovieViewModelProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data: MovieViewModelProtocol) {
        self.data = data
    }
    
    func populateData() {
        guard let data = self.data else {return}
        self.lblTitle.text = data.name
        self.movieImageView.loadImage(fromUrl: data.imageUrl)
    }
    
   
}
