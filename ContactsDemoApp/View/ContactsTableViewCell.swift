//
//  ContactsTableViewCell.swift
//  ContactsDemoApp
//
//  Created by Abhishek Gupta on 27/06/19.
//  Copyright © 2019 Abhishek Gupta. All rights reserved.
//
import Foundation
import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnFavourive: UIButton!
    @IBOutlet weak var lblFullName: UILabel!
    //@IBOutlet private weak var activityIndicator : UIActivityIndicatorView!
    
    private var imageDownloadingTask: CancelableTask?
    
    private var isLoading: Bool = false{
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.imgProfile.image = #imageLiteral(resourceName: "bg_placeholder")
                    //self.activityIndicator.startAnimating()
                }else {
                    //self.activityIndicator.stopAnimating()
                    //self.activityIndicator.isHidden = true
                }
            }
        }
    }
    
    //MARK:- LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.imgProfile.layer.borderWidth = 1
        self.imgProfile.layer.masksToBounds = false
        self.imgProfile.layer.borderColor = UIColor.black.cgColor
        self.imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        
        self.btnFavourive.isHidden = true
        self.btnFavourive.isSelected = false;
        self.lblFullName.text = ""
        self.imgProfile.image = #imageLiteral(resourceName: "bg_placeholder")
    }

    /*var contactPersonData:ContactsViewModel? {
        didSet{
            //imgProfile.image = contactPersonData?.profile_pic
            lblFullName.text = "\(String(describing: contactPersonData?.first_name))\(String(describing: contactPersonData?.last_name))"
        }
    }*/
    
    func configure(_ data: ContactsViewModel) {
        self.lblFullName.text = String(data.first_name ?? "") + " " + String(data.last_name ?? "")
        
        let favourite = Bool(data.favorite ?? false)
        if favourite{
            self.btnFavourive.isHidden = false
            self.btnFavourive.isSelected = true
        }
        
        self.imgProfile.image = #imageLiteral(resourceName: "bg_placeholder")
        imageDownloadingTask?.cancelTask()
        var imageurl: String = ""
        //unwrap optional
        if let url = data.profile_pic {
            if (url.hasSuffix("missing.png")){
                imageurl = "\(Constant.BASEURL)\(String(describing: url))"
                //print(imageurl)
            }else{
                imageurl = url
            }
        }
        imageDownloadingTask = imgProfile.loadImage(fromURL: imageurl, placeholder: #imageLiteral(resourceName: "bg_placeholder")) { (status, _) in
            if case .downloading = status {
                self.isLoading = true
            }else {
                self.isLoading = false
            }
        }
    }
}


