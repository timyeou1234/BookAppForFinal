//
//  BookPageViewController.swift
//  BookApp
//
//  Created by YeouTimothy on 2016/7/22.
//  Copyright © 2016年 YeouTimothy. All rights reserved.
//

import UIKit
import SDWebImage
import MapKit

class BookPageViewController: UIViewController {
    
    var book = [String:String]()

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var publisherLable: UILabel!
    @IBOutlet weak var bookUrl: UIButton!
    @IBOutlet weak var phoneButtonOutlet: UIButton!
    @IBOutlet weak var contextSummaryLable: UILabel!
    @IBOutlet weak var bookImageWidth: NSLayoutConstraint!
    @IBAction func callAction(sender: AnyObject) {
        let phoneNum = book["publisherPhone"]
        
        let url:NSURL = NSURL(string:"tel://" + phoneNum!)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func map(sender: AnyObject) {
        let address = book["publisherGlocation"]
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address!, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                coordinates.latitude
                coordinates.longitude
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary:nil))
                mapItem.name = "here"
                mapItem.openInMapsWithLaunchOptions([MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                
            }
        })
    }
    @IBAction func openUrl(sender: AnyObject) {
        let url = NSURL(string: book["bookUrl"]!)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(BookPageViewController.tapDetected))
        singleTap.numberOfTapsRequired = 1
        bookImage.userInteractionEnabled = true
        bookImage.addGestureRecognizer(singleTap)

    }
    
    override func viewWillAppear(animated: Bool) {
        
        let url = NSURL(string: book["photoUrl"]!)
        bookImage.sd_setImageWithURL(url)
        nameLable.text = book["name"]
        publisherLable.text = book["publisher"]
        phoneButtonOutlet.setTitle(book["publisherPhone"], forState: .Normal)
        contextSummaryLable.text = book["bookSummary"]
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapDetected() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        if bookImageWidth.constant == 150{
            bookImageWidth.constant = screenWidth
        }else{
            bookImageWidth.constant = 150
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
