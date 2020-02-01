//
//  TrailerView2Controller.swift
//  flixster
//
//  Created by angela on 2/1/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import WebKit

class TrailerView2Controller: UIViewController, WKUIDelegate{
    @IBOutlet weak var trailerWebView: WKWebView!
    var key: String = ""
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        trailerWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        trailerWebView.uiDelegate = self
        view = trailerWebView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let URLlink = "https://www.youtube.com/watch?v=" + self.key
        let myURL = URL(string:URLlink)
        let myRequest = URLRequest(url: myURL!)
        trailerWebView.load(myRequest)
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
