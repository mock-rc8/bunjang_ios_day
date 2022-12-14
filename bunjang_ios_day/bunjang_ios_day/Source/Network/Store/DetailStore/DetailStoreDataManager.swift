//
//  DetailStoreDataManager.swift
//  bunjang_ios_day
//
//  Created by ์๋ค์ on 2022/09/01.
//

import Foundation
import Alamofire
import Kingfisher

final class DetailStoreDataManager {
    
    func getDetailStoreData(storeID: Int, delegate: MyPageViewController) {
        
        let countURL = URLs.detailStoreURL.replacingOccurrences(of: "{:storeId}", with: "\(storeID)")
        let url = URLs.baseURL+countURL
        
        print("url : \(url)")
        
        let header: HTTPHeaders = [
            "X-ACCESS-TOKEN": Constant.jwt!
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: header)
        .validate()
        .responseDecodable(of: DetailStoreResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("๐ฅโผ๏ธ์์  ์ ๋ณดโผ๏ธresponse.result : \(response.result)๐ฅ")
                    delegate.storeData = response.result
                    
                    if response.result.profileImgURL != nil {
                        let imageURL = URL(string: response.result.profileImgURL!)
                        delegate.profileImage.kf.setImage(with: imageURL)
                    } else {
                        delegate.profileImage.image = UIImage(named: "แแตแแฉแซแแณแแฉแแตแฏ")
                    }
                    
                    delegate.userName.text = response.result.storeName
                    
                } else {
                    switch response.code {
                    case 2001: print("JWT๋ฅผ ์๋ ฅํด์ฃผ์ธ์.")
                    case 2002: print("์ ํจํ์ง ์์ JWT์๋๋ค.")
                    case 2003: print("๊ถํ์ด ์๋ ์ ์ ์ ์ ๊ทผ์๋๋ค.")
                    default: print("default")
                    }
                }
            case .failure(let error):
                print("๐ฅโผ๏ธ์์  ์ ๋ณด ์๋ฌโผ๏ธ : \(error.localizedDescription)")
            }
            
        }
    }
}
