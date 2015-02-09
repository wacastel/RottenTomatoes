//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by William Castellano on 2/3/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var detailsScrollView: UIScrollView!
    @IBOutlet weak var textBackgroundLabel: UILabel!
    
    var selectedMovie: NSDictionary?
    var fullSizedLoaded: Bool = false
    var imageCache = [String : UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = self.selectedMovie?["title"] as NSString
        self.movieTitle.text = self.selectedMovie?["title"] as NSString
        
        let posters = self.selectedMovie?["posters"] as NSDictionary
        let posterUrl = posters["original"] as NSString
        
        // Check the image cache for the existing key. This is just a dictionary of UIImages.
        var image = self.imageCache[posterUrl]
        
        if (image == nil) {
            println("*** fetching thumbnail and full-sized images <\(posterUrl)> across the network! ***")
            self.loadThumbnailImage()
            self.loadFullSizedImage()
        }
        else {
            self.moviePoster.image = image
            println("*** full-sized image <\(posterUrl)> loaded successfully from image cache!")
        }
        
        movieDetailsLabel.numberOfLines = 0
        movieDetailsLabel.text = self.selectedMovie?["synopsis"] as NSString
    }
    
    func getFullSizedUrl(inputString: NSString) -> NSString {
        let newString = inputString.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        return newString
    }
    
    func loadThumbnailImage() {
        let posters = self.selectedMovie?["posters"] as NSDictionary
        let thumbnailUrl = posters["thumbnail"] as NSString
        //self.moviePoster.setImageWithURL(NSURL(string:thumbnailUrl))
        
        let image_url = NSURL(string: thumbnailUrl)
        let url_request = NSURLRequest(URL: image_url!)
        let placeholder = UIImage(named: "no_photo")
        
        moviePoster.setImageWithURLRequest(url_request, placeholderImage: placeholder,
            success: { (request:NSURLRequest!,response:NSHTTPURLResponse!, image:UIImage!) -> Void in
                if (self.fullSizedLoaded == false) {
                    self.moviePoster.alpha = 0.0
                    self.moviePoster.image = image
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.moviePoster.alpha = 1.0
                    })
                    println("*** thumbnail image fetched successfully from network! ***")
                }
            }, failure: nil)
    }
    
    func loadFullSizedImage() {
        let posters = self.selectedMovie?["posters"] as NSDictionary
        let posterUrl = posters["original"] as NSString
        let fullPosterUrl = getFullSizedUrl(posterUrl)
        //moviePoster.setImageWithURL(NSURL(string:fullPosterUrl))
        
        let image_url = NSURL(string: fullPosterUrl)
        let url_request = NSURLRequest(URL: image_url!)
        
        moviePoster.setImageWithURLRequest(url_request, placeholderImage: nil,
            success: { (request:NSURLRequest!,response:NSHTTPURLResponse!, image:UIImage!) -> Void in
                self.moviePoster.image = image
                self.fullSizedLoaded = true
                
                // Store the image in the image cache
                self.imageCache[posterUrl] = image
                
                println("*** full-sized image fetched successfully from network! ***")
                
            }, failure: nil)
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
