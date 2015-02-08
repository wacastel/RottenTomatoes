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
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var detailsScrollView: UIScrollView!
    @IBOutlet weak var textBackgroundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = self.selectedMovie?["title"] as NSString
        self.movieTitle.text = self.selectedMovie?["title"] as NSString
        let posters = self.selectedMovie?["posters"] as NSDictionary
        let posterUrl = posters["original"] as NSString
        let fullPosterUrl = getFullSizedUrl(posterUrl)
        moviePoster.setImageWithURL(NSURL(string:fullPosterUrl))
        movieDetailsLabel.numberOfLines = 0
        movieDetailsLabel.text = self.selectedMovie?["synopsis"] as NSString
    }
    
    func getFullSizedUrl(inputString: NSString) -> NSString {
        let newString = inputString.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        return newString
    }
    
    override func viewDidLayoutSubviews() {
        movieDetailsLabel.sizeToFit()
        movieTitle.sizeToFit()
        let totalWidth = movieDetailsLabel.frame.size.width
        let totalHeight = movieDetailsLabel.frame.size.height + movieTitle.frame.size.height + 400
        detailsScrollView.contentSize = CGSizeMake(totalWidth, totalHeight)
        detailsScrollView.bounces = false
        detailsScrollView.scrollEnabled = true
        textBackgroundLabel.backgroundColor = UIColor.blackColor()
        textBackgroundLabel.alpha = 0.5
        let bgFrameSizeWidth = self.view.frame.size.width
        let bgFrameSizeHeight = movieDetailsLabel.frame.size.height + movieTitle.frame.size.height + 20
        let bgFrameOriginX = CGFloat(0)
        let bgFrameOriginY = movieTitle.frame.origin.y
        textBackgroundLabel.frame = CGRect(x: bgFrameOriginX, y: bgFrameOriginY, width: bgFrameSizeWidth, height: bgFrameSizeHeight)
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
