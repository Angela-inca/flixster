//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by angela on 1/30/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String: Any]!
    var key = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTap)))
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.af_setImage(withURL: posterUrl)
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        backdropView.af_setImage(withURL: backdropUrl)
    }
    @objc func imageTap() {
            let baseUrl = "https://api.themoviedb.org/3/movie/"
            let id: Int = movie!["id"] as! Int
            let idString = String(id)
            let after = "/videos?api_key=114da5c95a029f2c8bd50ed13cef859b&language=en-US"
            let url = URL(string: baseUrl + idString + after)!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
               // This will run when the network request returns
               if let error = error {
                  print(error.localizedDescription)
               } else if let data = data {
                  let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                  let info = dataDictionary["results"] as! [[String: Any]]
                  // get one of the keys
                  self.key = info[0]["key"] as! String
               }
            }
            task.resume()
        if(self.key != ""){
            self.performSegue(withIdentifier: "trailer", sender: self.key)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trailer"{
            let trailerView = segue.destination as! TrailerViewController
            trailerView.key = sender as! String
        }
    }
}
