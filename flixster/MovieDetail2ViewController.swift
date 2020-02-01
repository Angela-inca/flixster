//
//  MovieDetail2ViewController.swift
//  flixster
//
//  Created by angela on 2/1/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetail2ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    var movie: [String: Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movie)
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        introductionLabel.text = movie["overview"] as? String
        introductionLabel.sizeToFit()
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.af_setImage(withURL: posterUrl)
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        backgroundView.af_setImage(withURL: backdropUrl)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
