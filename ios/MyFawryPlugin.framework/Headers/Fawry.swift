//
//  Fawry.swift
//  MyFawryPlugin
//
//  Created by Hussein Gamal Mohammed on 10/1/17.
//  Copyright © 2017 Hussein Gamal Mohammed. All rights reserved.
//

import UIKit



public class Fawry: NSObject {
    
//    public static var sharedInstance : Fawry? = Fawry()
    struct Static { static var instance: Fawry? }
    public class var sharedInstance: Fawry?
    {
        if Static.instance == nil { Static.instance = Fawry() }
        return Static.instance!
    }
    private var serverURL: String?
    private var merchantID: String?
    private var merchantRefNum: String?
    private var themeStyle: ThemeStyle!
    private var language: String!
    private var customParameters: AnyObject?
    private var GUID: String!
    private var currancy: Currancy?
    private var sdkFinishedBlock: ((_ transactionID: AnyObject?, _ FawryStatusCode: FawryStatusCode ) -> Void)?

    private var customerMobileNumber: String?
    private var customerEmailAddress: String?
    private var customerProfileId: String?
    var sdkTarget: SDKTarget?


    private override init() {
        
    }
    public func dispose() {
        
        FinancialTrxManager.sharedInstance.dispose()
        CustomerDataManager.sharedInstance.dispose()
        ShippingManager.sharedInstance.dispose()
        MerchantManager.sharedInstance.dispose()
        CardTokenizerManager.sharedInstance.dispose()
        
        merchantID = nil
        merchantRefNum = nil
        customerMobileNumber = nil
        customerEmailAddress = nil
        customerProfileId = nil
        Fawry.Static.instance = nil
        //Fawry.sharedInstance = nil

    }

    public func initialize(
        serverURL: String,
        styleParam: ThemeStyle,
        merchantIDParam: String,
        merchantRefNum: String?,
        languageParam: String,
        GUIDParam: String,
        customeParameterParam: AnyObject?,
        currancyParam: Currancy,
        items: [Item]) {
        self.sdkTarget = SDKTarget.fawryPayment

        if serverURL.isEmpty {
            print(Constants.serverURLCannotBeEmpty)
            return
        }
        
        if (!self.canOpenURL(string: serverURL))
        {
            print(Constants.invalidServerURL)
            return
        }
        
        if merchantIDParam.isEmpty {
            print(Constants.merchantIDCannotBeEmpty)
            return
        }
        
        if languageParam.isEmpty {
            print(Constants.LanguageCannotBeEmpty)
            return
        }
        
        if GUIDParam.isEmpty {
            print(Constants.GUIDCannotBeEmpty)
            return
        }
        
        if items.count == 0 {
            print(Constants.ItemsCannotBeEmpty)
//            completionBlock(nil, .EmptyItemsList)
            return
        }
        
        if !self.isItemsContentValid(items: items) {
            print(Constants.ItemsCannotContainInvalidData)
            return
        }
        
        self.sdkTarget = SDKTarget.fawryPayment
        self.serverURL = serverURL
        self.merchantID = merchantIDParam
        self.merchantRefNum = merchantRefNum
        self.language = languageParam
        self.GUID = GUIDParam
        self.themeStyle = styleParam
        self.customParameters = customeParameterParam
        self.currancy = currancyParam
        CustomerDataManager.sharedInstance.items = items

        UserDefaults.standard.set(1, forKey: ModelRequestObjectsJsonKeys.currentStep)
    
    }
    public func initializeCardTokenizer(
        serverURL: String,
        styleParam: ThemeStyle,
        merchantIDParam: String,
        languageParam: String,
        GUIDParam: String,
        customerMobileNumber: String,
        customerEmailAddress: String,
        customerProfileId: String,
        currancyParam: Currancy) throws{
        
        self.sdkTarget = SDKTarget.cardTokenizer

        if serverURL.isEmpty {
            print(Constants.serverURLCannotBeEmpty)
            throw ValidationError(message: Constants.serverURLCannotBeEmpty, view: nil)
            
        }
        if (!self.canOpenURL(string: serverURL))
        {
            print(Constants.invalidServerURL)
            throw ValidationError(message: Constants.invalidServerURL, view: nil)
        }

        if merchantIDParam.isEmpty {
            print(Constants.merchantIDCannotBeEmpty)
            throw ValidationError(message: Constants.merchantIDCannotBeEmpty, view: nil)

        }
        
        if languageParam.isEmpty {
            print(Constants.LanguageCannotBeEmpty)
            throw ValidationError(message: Constants.LanguageCannotBeEmpty, view: nil)
        }
        
        if GUIDParam.isEmpty {
            print(Constants.GUIDCannotBeEmpty)
            throw ValidationError(message: Constants.GUIDCannotBeEmpty, view: nil)
        }
        
       if customerEmailAddress.isEmpty {
            print(Constants.CustomerEmailCannotBeEmpty)
            throw ValidationError(message: Constants.CustomerEmailCannotBeEmpty, view: nil)
        }
        
        if customerMobileNumber.isEmpty {
            print(Constants.CustomerMobileCannotBeEmpty)
            throw ValidationError(message: Constants.CustomerMobileCannotBeEmpty, view: nil)
        }
        
        if !MWalletValidationManager.sharedInstance().isProperEgyptianNumber(customerMobileNumber){
            print(Constants.InvalidCustomerMobileNumber)
            throw ValidationError(message: Constants.InvalidCustomerMobileNumber, view: nil)
        }
        
        if customerProfileId.isEmpty {
            print(Constants.CustomerProfileIDCannotBeEmpty)
            throw ValidationError(message: Constants.CustomerProfileIDCannotBeEmpty, view: nil)
        }
        
        self.sdkTarget = SDKTarget.cardTokenizer
        self.serverURL = serverURL
        self.customerMobileNumber = customerMobileNumber
        self.customerEmailAddress = customerEmailAddress
        self.customerProfileId = customerProfileId
        
        self.merchantID = merchantIDParam
        self.language = languageParam
        self.GUID = GUIDParam
        self.themeStyle = styleParam
        self.currancy = currancyParam
        
//        UserDefaults.standard.set(1, forKey: ModelRequestObjectsJsonKeys.currentStep)
        
    }
    
    public func showSDK(
        onViewController: UIViewController ,
        completionBlock: @escaping (_ transactionID: AnyObject?, _ FawryStatusCode: FawryStatusCode) -> Void){

            NotificationCenter.default.addObserver(self, selector: #selector(executeCompletionBlock), name: NSNotification.Name(rawValue: Constants.transactionObserverMethod), object: nil)
            
        let bundle = Bundle.init(for: self.classForCoder)
        guard let serverURL = self.serverURL else { return }
        
        guard let currancy = self.currancy else { return }
        CustomerDataManager.sharedInstance.currancy = currancy.rawValue
        CustomerDataManager.sharedInstance.lang = self.language
        
            
        self.sdkFinishedBlock = completionBlock
        
        if(self.sdkTarget == SDKTarget.fawryPayment)
        {
            guard let merchantID = self.merchantID else { return }
            ModelRequestObjectsJsonKeys.domainURL = serverURL

            LoadingAnimation.sharedInstance.showActivityIndicatory(uiView: onViewController.view, title: NSLocalizedString(languageKeys.ExtraLanguageKeys.IntializngPlugin, tableName: languageKeys.ExtraLanguageKeys.fileName, bundle: bundle, value: "", comment: ""))
            
            MerchantManager.sharedInstance.getMerchantInfo(accountNumber: merchantID) { (merchant, message) in
                LoadingAnimation.sharedInstance.removeActivityIndicator(uiView: onViewController.view)
                
                if (merchant != nil) {
                   MerchantManager.sharedInstance.merchantRefNum = self.merchantRefNum
                        FinancialTrxManager.sharedInstance.addToReceipt(item: ReceiptItem(amount: (CustomerDataManager.sharedInstance.calculateTotalAmountForCustomerItems()), key: Constants.OrderAmount, reciptItemType: ReciptItemType.OrderAmount))
                    
                        self.pushToNotificationViewControllerWithBaseViewController(baseViewController: onViewController)

                }else{
                    self.presnetErrorMessage(message: message!, Title: ValidationErrorTitle.connectionError.rawValue, onViewController: onViewController)
                }
            }
        }else if(self.sdkTarget == SDKTarget.cardTokenizer){
            

            guard let merchantID = self.merchantID else { return }
            guard let customerProfileId = self.customerProfileId else { return }
            guard let customerMobileNumber = self.customerMobileNumber else { return }
            guard let customerEmailAddress = self.customerEmailAddress else { return }
            
            ModelRequestObjectsJsonKeys.CardTokenizer.domainURL = serverURL

            let model = CardTokenizerRequestParams(
                merchantCode: merchantID,
                customerProfileId: customerProfileId,
                customerMobile: customerMobileNumber,
                customerEmail: customerEmailAddress,
                cardNumberParam: "",
                expiryDateYearParam: "",
                expiryDateMonthParam: "",
                cvvParam: "")
            
            self.pushToCardTokenizerViewControllerWithBaseViewController(baseViewController: onViewController, model: model)
        }

    }

    
    public func applyFawryButtonStyleToButton(button: UIButton) {
//        button.setBackgroundImage(, for: .normal)
        
        

        
        
        button.setBackgroundImage(UIImage(named: "@fawry", in: Bundle(for: MyFawryPlugin_RecepitViewController.self), compatibleWith: nil), for: .normal)
        
        
        button.setTitle("", for: .normal)

    }
    func updatePluginCompletionBlockParams(blockParams: (String, FawryStatusCode)) {
      

            UserDefaults.standard.removeObject(forKey: Constants.PluginCompletionBlockTransactionIDParam)
            UserDefaults.standard.removeObject(forKey: Constants.PluginCompletionBlockStatusCodeParam)
            
            UserDefaults.standard.set(blockParams.0 , forKey: Constants.PluginCompletionBlockTransactionIDParam)
            UserDefaults.standard.set(blockParams.1.rawValue , forKey: Constants.PluginCompletionBlockStatusCodeParam)



    
    }
    func loadPluginCompletionBlock() -> (String, Int) {
        
        var pair = ("",0)
        if let transactionID = UserDefaults.standard.value(forKey: Constants.PluginCompletionBlockTransactionIDParam) {
            pair.0 = transactionID as! String
        }
        if let statusCodeIncoming = UserDefaults.standard.value(forKey: Constants.PluginCompletionBlockStatusCodeParam) {
            pair.1 = statusCodeIncoming as! Int
            
        }
        return pair
    }

    @objc private func executeCompletionBlock(notification: Notification){

            let pairFromDefaults = loadPluginCompletionBlock()
        if (sdkTarget == SDKTarget.fawryPayment){
            
            sdkFinishedBlock!((pairFromDefaults.0 as AnyObject), FawryStatusCode(rawValue: pairFromDefaults.1)!)
        
        }else if(sdkTarget == SDKTarget.cardTokenizer){
            
            let jsonData = JSON.parse(pairFromDefaults.0)
            let cardTokenizerInfo = CardTokenizerInfo(json: jsonData)
            
            sdkFinishedBlock!(cardTokenizerInfo, FawryStatusCode(rawValue: pairFromDefaults.1)!)
        }
        

        
    }
    private func pushToNotificationViewControllerWithBaseViewController(baseViewController: UIViewController){
        let s = UIStoryboard (name: "MyFawryPlugin_Notification", bundle: Bundle(for: MyFawryNavigationViewController_Notification.self))
        
        let vc = s.instantiateViewController(withIdentifier: "MyFawryNavigationViewController_Notification") as! MyFawryNavigationViewController_Notification
        
        OperationQueue.main.addOperation({
            baseViewController.present(vc, animated: true, completion: nil)
        })
        
    }
    private func pushToCardTokenizerViewControllerWithBaseViewController(
        baseViewController: UIViewController, model: CardTokenizerRequestParams){
        let s = UIStoryboard (
            name: "MyFawryPlugin_CardTokenizer",
            bundle: Bundle(for: MyFawryNavigationViewController_CardTokenizer.self))
        
        let vc = s.instantiateViewController(withIdentifier: "MyFawryNavigationViewController_CardTokenizer") as! MyFawryNavigationViewController_CardTokenizer
        
        
        OperationQueue.main.addOperation({
            baseViewController.present(vc, animated: true, completion: nil)
            (vc.viewControllers[0] as! MyFawryPlugin_CardTokenizerViewController).model = model
        })
        
    }

    private func presnetErrorMessage(message: String, Title: String,onViewController: UIViewController) {
        let alertControl = UIAlertController.init(title: Title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alertControl.addAction(okAction)
        
        onViewController.present(alertControl, animated: true, completion: nil)
    }
    
    func isItemsContentValid(items: [Item]) -> Bool {
        for item in items {
            if item.price <= 0 || item.quantity <= 0 {
                return false
            }
        }
        return true
    }
    
    func canOpenURL(string: String?) -> Bool {
        guard let urlString = string else { return false }
        guard let url = NSURL(string: urlString) else { return false }
        if !UIApplication.shared.canOpenURL(url as URL) { return false }
        
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
}
