//
//  MyPageCountDataManager.swift
//  bunjang_ios_day
//
//  Created by ์๋ค์ on 2022/08/30.
//

import Foundation
import Alamofire

final class MyPageCountDataManager {
    
    func getMyPageCount(storeID: Int, delegate: MyPageViewController) {
        
        let countURL = URLs.myPageURL.replacingOccurrences(of: "{:storeId}", with: "\(storeID)")
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
        .responseDecodable(of: CountResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("๐ฅโผ๏ธ๋ง์ดํ์ด์งโผ๏ธresponse.message : \(response.result)")
                    delegate.myPageCount = response.result
                    delegate.collectionView.reloadData()
                } else {
                    switch response.code {
                    case 2001: print("JWT๋ฅผ ์๋ ฅํด์ฃผ์ธ์.")
                    case 2002: print("์ ํจํ์ง ์์ JWT์๋๋ค.")
                    case 2003: print("๊ถํ์ด ์๋ ์ ์ ์ ์ ๊ทผ์๋๋ค.")
                    default: print("default")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
}
