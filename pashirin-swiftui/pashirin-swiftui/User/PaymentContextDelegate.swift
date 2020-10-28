//
//  PaymentContextDelegate.swift
//  stripePayment_Pashirin
//
//  Created by Eri Koyano on 2020/10/23.
//

import Foundation
import Stripe
import SwiftUI

class PaymentContextDelegate: NSObject, STPPaymentContextDelegate, ObservableObject {
    
    @Published var paymentMethodButtonTitle = "Pay Now"
    @Published var showAlert = false
    @Published var message = ""
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        let title: String
        var message: String
        
        switch status {
        case .success:
            
            title = "Success!"
            message = "Thank you for your purchase."
            showAlert = true
            self.message = message
        case .error:
            
            title = "Error"
            message = error?.localizedDescription ?? ""
            showAlert = true
            self.message = message
        case .userCancellation:
            return
        @unknown default:
            fatalError("Something really bad happened....")
        }
    }
    
    
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
        paymentMethodButtonTitle = paymentContext.selectedPaymentOption?.label ?? "Pay Now"
        
        //updating the selected shipping method
        
        
        //       shippingMethodButtonTitle = paymentContext.selectedShippingMethod?.label ?? "Select Shipping Method"
        
    }
    
    //            func paymentContext(_ paymentContext: STPPaymentContext, didUpdateShippingAddress address: STPAddress, completion: @escaping STPShippingMethodsCompletionBlock) {
    //               // isSetShipping = false
    //
    //                let upsGround = PKShippingMethod()
    //                upsGround.amount = 0
    //                upsGround.label = "UPS Ground"
    //                upsGround.detail = "Arrives in 3-5 days"
    //                upsGround.identifier = "ups_ground"
    //
    //                let fedEx = PKShippingMethod()
    //                fedEx.amount = 5.99
    //                fedEx.label = "FedEx"
    //                fedEx.detail = "Arrives tomorrow"
    //                fedEx.identifier = "fedex"
    //
    //                if address.country == "US" {
    //                    completion(.valid, nil, [upsGround, fedEx], upsGround)
    //                }
    //                else {
    //                    completion(.invalid, nil, nil, nil)
    //                }
    //            }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        //
        
        //                guard let customerId = UserDefaults.standard.value(forKey: "Customer") as? String else {
        //                           print("this is not woooorking")
        //                           return
        //                       }
        let customerId = "cus_IF8Whx1Qc2jNuz"
        let paymentAmount = paymentContext.paymentAmount
        
        print("TOTAL: \(paymentAmount)")
        
        
        
        createPaymentIntent(amount: paymentAmount, currency: "jpy", customerId: customerId) { (reponseString) in
            
            
            // Assemble the PaymentIntent parameters
            let paymentIntentParams = STPPaymentIntentParams(clientSecret: reponseString)
            paymentIntentParams.paymentMethodId = paymentResult.paymentMethod.stripeId
//            paymentIntentParams.paymentMethodParams = paymentResult.paymentMethodParams
            //callign method
            STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: paymentContext) { status, paymentIntent, error in
                switch status {
                case .succeeded:
                    // Your backend asynchronously fulfills the customer's order, e.g. via webhook
                    print("SUCCESS!")
                    
                    completion(.success, nil)
                case .failed:
                    completion(.error, error) // Report error
                case .canceled:
                    completion(.userCancellation, nil) // Customer cancelled
                @unknown default:
                    completion(.error, nil)
                }
            }
            
        }
    }
    
}


