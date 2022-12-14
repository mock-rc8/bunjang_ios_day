//
//  RegisteredProductDataManager.swift
//  bunjang_ios_day
//
//  Created by ์๋ค์ on 2022/08/31.
//

import Foundation
import Alamofire
import ImageSlideshow

final class RegisteredProductDataManager {
    
    func getProductData1(productID: Int, delegate: SalesViewController) {
        let url = URLs.baseURL+URLs.detailProductURL+"\(productID)"
        print(#function)
        print("url : \(url)")
        
        let header: HTTPHeaders = [
            "X-ACCESS-TOKEN": Constant.jwt!
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: header)
        .validate()
        .responseDecodable(of: RegisteredProductResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("๐ฅโผ๏ธ๋ํ์ผ๋ทฐโผ๏ธresponse.result : \(response.result)")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                    vc.productData = response.result
                    
                    let images = response.result.imageUrls
                    for i in images {
                        if i != "" {
                            vc.imageInputs.append(KingfisherSource(urlString: i)!)
                        }
                        else { break }
                    }
                    
                    delegate.navigationController?.pushViewController(vc, animated: true)
                } else {
                    switch response.code {
                    case 2001: print("JWT๋ฅผ ์๋ ฅํด์ฃผ์ธ์.")
                    case 2002: print("์ ํจํ์ง ์์ JWT์๋๋ค.")
                    case 2003: print("์กด์ฌํ์ง ์๋ ์์  id ์๋๋ค.")
                    case 3302: print("ํด๋น ์ฌ์ฉ์๊ฐ ์ ๊ทผํ  ์ ์๋ ์ํ์๋๋ค.")
                    default: print("default")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func getProductData2(productID: Int, delegate: SalesViewController) {
        let url = URLs.baseURL+URLs.detailProductURL+"\(productID)"
        
        print("url : \(url)")
        
        let header: HTTPHeaders = [
            "X-ACCESS-TOKEN": Constant.jwt!
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: header)
        .validate()
        .responseDecodable(of: RegisteredProductResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("๐์ํ ์์ ํ๊ธฐ : \(response.result)๐")
                    let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SellProductViewController") as! SellProductViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.tabBarController?.tabBar.isHidden = true
                    vc.receiveName = response.result.name
                    vc.receivePrice = "\(response.result.price)"
                    vc.receiveContent = response.result.content
                    vc.update = true
                    vc.registeredImageNum = response.result.imageUrls.count
                    vc.imageURLs = response.result.imageUrls
                    vc.registeredProduct = response.result
                    
                    delegate.present(vc, animated: true)
                } else {
                    switch response.code {
                    case 2001: print("JWT๋ฅผ ์๋ ฅํด์ฃผ์ธ์.")
                    case 2002: print("์ ํจํ์ง ์์ JWT์๋๋ค.")
                    case 2003: print("์กด์ฌํ์ง ์๋ ์์  id ์๋๋ค.")
                    case 3302: print("ํด๋น ์ฌ์ฉ์๊ฐ ์ ๊ทผํ  ์ ์๋ ์ํ์๋๋ค.")
                    default: print("default")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func getProductData3(productID: Int, delegate: MainCollectionViewController) {
        print(#function)
        let url = URLs.baseURL+URLs.detailProductURL+"\(productID)"
        
        print("url : \(url)")
        
        let header: HTTPHeaders = [
            "X-ACCESS-TOKEN": Constant.jwt!
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: header)
        .validate()
        .responseDecodable(of: RegisteredProductResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("๐ฅโผ๏ธํํ๋ฉด -> ๋ํ์ผ๋ทฐโผ๏ธresponse.result : \(response.result)")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                    vc.productData = response.result
                    
                    let images = response.result.imageUrls
                    for i in images {
                        if i != "" {
                            vc.imageInputs.append(KingfisherSource(urlString: i)!)
                        }
                        else { break }
                    }
                    
                    delegate.navigationController?.pushViewController(vc, animated: true)
                } else {
                    switch response.code {
                    case 2001: print("JWT๋ฅผ ์๋ ฅํด์ฃผ์ธ์.")
                    case 2002: print("์ ํจํ์ง ์์ JWT์๋๋ค.")
                    case 2003: print("์กด์ฌํ์ง ์๋ ์์  id ์๋๋ค.")
                    case 3302: print("ํด๋น ์ฌ์ฉ์๊ฐ ์ ๊ทผํ  ์ ์๋ ์ํ์๋๋ค.")
                    default: print("default")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
