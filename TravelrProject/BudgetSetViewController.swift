//
//  BudgetSetViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 17..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit
import MobileCoreServices

class BudgetSetViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate {
    
    var imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage:UIImage!
    var flagImageSave = false

    @IBOutlet weak var cardBudgetSet: UITextField!
    
    @IBOutlet weak var cashBudgetSet1: UITextField!
    
    @IBOutlet weak var cashBudgetSet2: UITextField!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    
    var titlename:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTextFields()
        
        navTitle.title = titlename
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
    func initializeTextFields() {
        cardBudgetSet.delegate = self
        cardBudgetSet.keyboardType = UIKeyboardType.NumberPad
        
        cashBudgetSet1.delegate = self
        cashBudgetSet1.keyboardType = UIKeyboardType.NumberPad
        
        cashBudgetSet2.delegate = self
        cashBudgetSet2.keyboardType = UIKeyboardType.NumberPad
        
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBAction func loadingImgView(sender: AnyObject) {

    if(UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)){
            flagImageSave = false
        
        
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
        
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    else {
        
        imageAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqualToString(kUTTypeImage as NSString as String){
            
            captureImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            if flagImageSave{
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 이미지 경고창띄우는것
    func imageAlert(title: String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var currencySet: UILabel!
    
    @IBOutlet weak var currencySegment: UISegmentedControl!
    
    @IBAction func currencySetting(sender: AnyObject) {
        
        for i in 0...3{
            
            if currencySegment.selectedSegmentIndex == i {
                
                currencySet.text = currencySegment.titleForSegmentAtIndex(i)
                
            }
        }
        
    }
    
    
    
    
    
    @IBAction func makeTravel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: {
        })
        
        
    }
    
    
    
    
    
    
    func addTravel() {
        
        
        let newTravel = TravelWhere(titlename!, "20100905-20100910", Budget(0,0,Currency(rawValue: 0)!), [Budget(1,0,Currency(rawValue: 0)!)])
        
        
        
        if let cardBudget = cardBudgetSet.text {
            
            var cardbudget:Budget
            let cardMoney = (cardBudget as NSString).doubleValue
            cardbudget = Budget(0, cardMoney, Currency(rawValue: 0)!)
            newTravel.initCardBudget = cardbudget
        }
        
        if let cashBudget1 = cashBudgetSet1.text{
            
            var cashbudget:[Budget] = []
            let cashMoney1 = (cashBudget1 as NSString).doubleValue
            cashbudget.append(Budget(1, cashMoney1, Currency(rawValue: currencySegment.selectedSegmentIndex)!))
            newTravel.initCashBudget = cashbudget
        }
        
        if let cashBudget2 = cashBudgetSet2.text{
            
            var cashbudget:Budget
            let cashMoney2 = (cashBudget2 as NSString).doubleValue
            cashbudget = Budget(1, cashMoney2, Currency(rawValue: 0)!)
            newTravel.initCashBudget.append(cashbudget)
            
        }
        
        
        dataCenter.travels.append(newTravel)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        self.addTravel()
        let destVC1 = segue.destinationViewController as! MainViewController

        let title1 = dataCenter.travels[1].title
        let cardMoney = dataCenter.travels[0].title
        
        destVC1.money = cardMoney
        destVC1.title = title1
        
        //textfield 숫자로 변화해야함;;
//
//        
//        
//            let cashMoney = (cashBudget as NSString).doubleValue
//        }
        
        
//        if budgetList
//        let cashMoney = ( as NSString).doubleValue
//        
//       destVC1.cardBudget = Budget(0, cardMoney, Currency(rawValue: 0)!)
//        destVC1.cashBudget =
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
    

}
