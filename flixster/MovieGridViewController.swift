//
//  MovieGridViewController.swift
//  flixster
//
//  Created by angela on 1/30/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviegridCell", for: indexPath) as! MoviegridCell
        let movie = movies[indexPath.item]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        cell.posterView.af_setImage(withURL: posterUrl)
        return cell
    }
    
    var movies = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height : width * 3 / 2)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              // TODO: Get the array of movies
            self.movies = dataDictionary["results"] as! [[String: Any]]
            self.collectionView.reloadData()
            
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
       

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let cell = sender as! MoviegridCell
        let indexPath = collectionView.indexPath(for: cell)
        //to retrieve an element from collectionView use indexPath.item instead of indexPath.row
        let movie = movies[indexPath!.item]
        let detailsViewController = segue.destination as! MovieDetail2ViewController
        //pass the selected movie to the details view controller
        detailsViewController.movie = movie
        collectionView.deselectItem(at: indexPath!, animated: true)
        
        // Pass the selected object to the new view controller.
    }
    

}
