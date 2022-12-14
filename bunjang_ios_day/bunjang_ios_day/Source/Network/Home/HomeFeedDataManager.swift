//
//  HomeFeedDataManager.swift
//  bunjang_ios_day
//
//  Created by ์๋ค์ on 2022/09/02.
//

import Foundation
import Alamofire
import Kingfisher

final class HomeFeedDataManager {
    
    func getHomeFeedData(page: Int, delegate: MainCollectionViewController) {
        
        let url = URLs.baseURL+URLs.homeURL+"\(page)"
        
        print("url : \(url)")
        
        let header: HTTPHeaders = [
            "X-ACCESS-TOKEN": Constant.jwt!
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: header)
        .validate()
        .responseDecodable(of: HomeFeedResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("๐ฅโผ๏ธํ ํผ๋ ์ ๋ณดโผ๏ธresponse.result : \(response.result)๐ฅ")
                    delegate.feedData = response.result
                    print("๐ฅโผ๏ธํ ํผ๋ ์ ๋ณดโผ๏ธdelegate.feedData : \(delegate.feedData)๐ฅ")
                    delegate.collectionView.reloadData()
                }
                else {
                    switch response.code {
                    case 2001: print("JWT๋ฅผ ์๋ ฅํด์ฃผ์ธ์.")
                    case 2002: print("์ ํจํ์ง ์์ JWT์๋๋ค.")
                    case 2003: print("๊ถํ์ด ์๋ ์ ์ ์ ์ ๊ทผ์๋๋ค.")
                    default: print("default")
                    }
                }
            case .failure(let error):
                do{
                    let result = try JSONDecoder().decode(HomeFeedResponse.self, from: response.data!)
                    print("์คํจ result : \(result)")
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                print("๐ฅโผ๏ธํ ํผ๋ ์๋ฌโผ๏ธ : \(error.localizedDescription)")
            }
        }
    }
}
