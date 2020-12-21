//
//  UITableViewController+Acitivity.swift
//  Optus_POC
//
//  Created by Rohit on 12/21/20.
//

import UIKit

var activityLoaderView: UIView?

extension UITableViewController {
    
    open override func viewDidLoad() {
        
        //perform internet check each time table view controller is laoded
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")
            displayErrorMessageWith(messageString: "Please connect to internet")
        }
    }
    
    //MARK: - Method Activity Indicator
    
    ///function to add activity indicator on view controller
    func addActivityIndicator() {
        activityLoaderView = UIView(frame: self.view.bounds)
        activityLoaderView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = activityLoaderView!.center
        activityIndicator.startAnimating()
        activityLoaderView?.addSubview(activityIndicator)
       
        self.view.addSubview(activityLoaderView!)
        self.view.bringSubviewToFront(activityLoaderView!)
    }
    
    ///function to remove activity indicator from view controller
    func stopActivityIndicator() {
        activityLoaderView?.removeFromSuperview()
        activityLoaderView = nil
    }
    
    /// Method to dsiplay error messages on veiwcontroller
    ///
    /// - Parameter messageString: String to be used while displaying error message
    func displayErrorMessageWith(messageString:String) {
        let alert = UIAlertController(title: NSLocalizedString("ErrorHeader", comment: ""), message: messageString , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OkButton", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
