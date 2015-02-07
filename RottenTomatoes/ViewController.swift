//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by William Castellano on 2/3/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var moviesArray: NSArray?
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var synopsis: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        println("*** viewDidAppear")
        super.viewDidAppear(animated)
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.fetchDataFromServer()
    }
    
    func fetchDataFromServer()
    {
        SVProgressHUD.show()
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=ydbs77ay89298mprwm6xbxje"
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        
        println("*** loading from network! ***")
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
            if ((error) != nil) {  // a networking error occurred - display an error message
                println("*** Error retrieving data: \(error) ***")
                self.networkErrorView.hidden = false
                
            }
            else {
                self.networkErrorView.hidden = true
                var errorValue: NSError? = nil
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                self.moviesArray = dictionary["movies"] as? NSArray
                self.tableView.reloadData()
                println("*** done loading from network! ***")
            }
            SVProgressHUD.dismiss()
        })
    }
    
    func refresh(sender:AnyObject)
    {
        println("*** refreshing...")
        // Updating your data here...
        fetchDataFromServer()
        
        self.refreshControl?.endRefreshing()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = moviesArray {
            return array.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        let posters = movie["posters"] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.mycell") as MovieTableViewCell
        cell.movieTitleLabel.text = movie["title"] as NSString
        cell.movieSynopsisLabel.text = movie["synopsis"] as NSString
        let thumbnailUrl = posters["thumbnail"] as NSString
        //let thumbnailUrl = "http://images.forbes.com/media/lists/companies/apple_200x200.jpg"
        cell.movieTitleThumbnail.setImageWithURL(NSURL(string:thumbnailUrl))
        return cell
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let details = MovieDetailsViewController()
        //let movie = self.moviesArray![indexPath.row] as NSDictionary
        //details.moviesDictionary = movie
        //self.navigationController?.pushViewController(details, animated: true)
    }*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var vc = segue.destinationViewController as MovieDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as UITableViewCell) as NSIndexPath!
        vc.selectedMovie = self.moviesArray![indexPath.row] as? NSDictionary
    }

}

