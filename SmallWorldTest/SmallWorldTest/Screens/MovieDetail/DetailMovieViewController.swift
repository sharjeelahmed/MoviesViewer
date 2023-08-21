//
//  MovieDetailViewController.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import Foundation
import UIKit

class DetailMovieViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var productionCountriesLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!

    var viewModel: DetailMovieViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.viewModel.fetchMovieDetails()
        }
        
        viewModel.onLoadData = { [weak self] details in
            DispatchQueue.main.async {
                self?.configure(details)
            }
        }
    }
    
    func configure(_ details: MovieDetailsViewModelProtocol) {
        titleLabel.text = details.title
        overviewLabel.text = details.overview
        releaseDateLabel.text = details.releaseDate
        voteAverageLabel.text = details.voteAverage
        genresLabel.text = details.genres
        productionCountriesLabel.text = details.productionCountries
        imageView.loadImage(fromUrl: details.imageUrl)
        tagLineLabel.text = details.tagline
    }
}

