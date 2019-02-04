//
//  CarDetailsViewController.swift
//  CarsDemo
//
//  Created by Abhishek Chaudhari on 08/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import UIKit

class CarDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ingressLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailsScrollView: UIScrollView!
    
    
    var carDetails: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Car Details"
        self.initializer()
        self.datainitializer()
    }
    
    func datainitializer(){
        titleLabel.text = carDetails.title
        timeLabel.text = Date.getTimeString(fromTimeStamp: carDetails.created)
        ingressLabel.text = carDetails.ingress
        subjectLabel.text = carDetails.content?.subject
        descriptionLabel.text = carDetails.content?.desc
        
        if (carDetails.image != nil) {
            carImageView.sd_setImage(with: URL(string: carDetails.image!), placeholderImage: nil, options: .progressiveDownload, completed: nil)
        }else{
            carImageView.image = nil
        }
    }
    
    func initializer(){
        titleLabel.font = UIFont.detailTitle
        titleLabel.textColor = UIColor.darkGreyBlue
        
        timeLabel.font = UIFont.dateTime
        timeLabel.textColor = UIColor.greyish
        
        ingressLabel.font = UIFont.detailIngress
        ingressLabel.textColor = UIColor.greyBlue
        
        subjectLabel.font = UIFont.detailSubject
        subjectLabel.textColor = UIColor.darkGreyBlue
        
        descriptionLabel.font = UIFont.detailDescription
        descriptionLabel.textColor = UIColor.greyBlue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        detailsScrollView.updateContentView()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
