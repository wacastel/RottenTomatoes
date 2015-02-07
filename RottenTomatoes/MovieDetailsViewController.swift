//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by William Castellano on 2/3/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var selectedMovie: NSDictionary?
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.movieTitle.text = self.selectedMovie?["title"] as NSString
        let posters = self.selectedMovie?["posters"] as NSDictionary
        let posterUrl = posters["original"] as NSString
        //cell.movieTitleThumbnail.setImageWithURL(NSURL(string:thumbnailUrl))
        moviePoster.setImageWithURL(NSURL(string:posterUrl))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func loadView() {
        let myView = UIView(frame: CGRectZero)
        myView.backgroundColor = UIColor.greenColor()
        self.view = myView
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
