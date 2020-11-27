import Foundation
import Stripe
import Alamofire

class MyAPIClient: NSObject,STPCustomerEphemeralKeyProvider {
    
    #warning("Please use your own backend url below")
    let baseURL = "http://localhost:4242"
  
    //MARK: - STEP 1. Create customer KEY.
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
       
      //  let url = URL(string: "http://localhost:4242/ephemeral_keys")!
       // let url = URL(string:"https://pashirin-nodeserver.herokuapp.com/ephemeral_keys")!
       let url = URL(string:"https://pashirinback-staging.herokuapp.com/ephemeral_keys")!
      
            
        Alamofire.request(url, method: .post , parameters: [
                        "api_version": apiVersion,
                        "full_name": "eri koyano",
                        "customerId": "cus_IF8Whx1Qc2jNuz"
            
            ])
            .validate(statusCode: 200..<300)
            .responseJSON {responseJSON in
                switch responseJSON.result {
                case .success (let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
 

//MARK: - STEP 2. Create customer.
func createCustomer(email: String, phone: String, name: String, onSuccess: @escaping() -> Void, onError: @escaping(Error) -> Void){

        let createCustomerEndPoint = URL(string: "http://localhost:4242/create")

        guard let url = createCustomerEndPoint else {
            print("The url is not valid.")
            return
        }

    Alamofire.request(url, method: .post , parameters: [
                    "amount": "3000",
                    "currency": "jpy",
                    "customer": "cus_IF8Whx1Qc2jNuz",
                   // "customerId": "cus_IF8Whx1Qc2jNuz"

        ])
    .validate(statusCode: 200..<300)
    .responseString {response in
        switch response.result {
        case .success:
            let customerId = "cus_IF8Whx1Qc2jNuz"
            print("customerId: \(customerId)")
            UserDefaults.standard.set(customerId, forKey: "Customer")
            onSuccess()
        case .failure(let error):
            onError(error)
        }
    }
}



//MARK: - STEP 2. Create Paymnent intent
func createPaymentIntent(amount: Int, currency: String, customerId: String, completion:@escaping (String) -> Void) {
        
        let createCustomerEndPoint = URL(string: "http://localhost:4242/charge")
 
        
        guard let url = createCustomerEndPoint else {
            print("The url is not valid.")
            return
        }
        
    Alamofire.request(url, method: .post , parameters: [
                    "customerId": "cus_IF8Whx1Qc2jNuz",
                    "amount": amount,
                    "currency": "jpy",
                    "customer" : "cus_IF8Whx1Qc2jNuz"
        
        
        ])
        .validate(statusCode: 200..<300)
        .responseString {response in
            switch response.result {
            case .success:
                completion("complete")
            case .failure( _):
                completion("error")
            }
        }
    }


// STEP.3 create charge




//Payment Intent

