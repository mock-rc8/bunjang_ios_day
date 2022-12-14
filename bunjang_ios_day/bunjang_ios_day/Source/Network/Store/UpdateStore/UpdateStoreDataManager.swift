//
//  UpdateStoreDataManager.swift
//  bunjang_ios_day
//
//  Created by ์๋ค์ on 2022/09/01.
//

import Foundation
import Alamofire
import Kingfisher

final class UpdateStoreDataManager {
    
    func updateDetailStoreData(_ parameters: UpdateStoreRequest, storeID: Int, delegate: DetailStoreViewController) {
        
        let countURL = URLs.updateStoreURL.replacingOccurrences(of: "{:storeId}", with: "\(storeID)")
        let url = URLs.baseURL+countURL
        
        let header: HTTPHeaders = [
            "X-ACCESS-TOKEN": Constant.jwt!,
        ]
        
        print("url : \(url)")
        print("header : \(header)")
        print("๐ฅโผ๏ธ์์  ์ ๋ณด ์์  parameters : \(parameters)โผ๏ธ๐ฅ")
        
        
        AF.request(url,
                   method: .patch,
                   parameters: parameters,
                   encoder: JSONParameterEncoder(),
                   headers: header)
        .validate()
        .responseDecodable(of: UpdateStoreResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("๐ฅโผ๏ธ์์  ์ ๋ณด ์์  ์ฑ๊ณตโผ๏ธresponse.result : \(response.result)๐ฅ")
                    delegate.navigationController?.popViewController(animated: true)
                } else {
                    switch response.code {
                    case 2001: print("JWT๋ฅผ ์๋ ฅํด์ฃผ์ธ์.")
                    case 2002: print("์ ํจํ์ง ์์ JWT์๋๋ค.")
                    case 2003: print("๊ถํ์ด ์๋ ์ ์ ์ ์ ๊ทผ์๋๋ค.")
                    default: print("default")
                    }
                }
            case .failure(let error):
                do{
                    let result = try JSONDecoder().decode(UpdateStoreResponse.self, from: response.data!)
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
                print("๐ฅโผ๏ธ์์  ์ ๋ณด ์์  ์๋ฌโผ๏ธ : \(error.localizedDescription)")
            }
            
        }
    }
}

