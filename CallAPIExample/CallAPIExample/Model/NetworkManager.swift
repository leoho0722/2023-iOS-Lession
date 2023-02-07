//
//  NetworkManager.swift
//  CallAPIExample
//
//  Created by Leo Ho on 2023/2/3.
//

import Foundation

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    /// 請求網路資料
    /// - Parameters:
    ///   - offset: 要跳過幾筆資料，預設為 0，不跳過任何資料
    ///   - limit: 要請求幾筆資料
    ///   - finish: 請求完網路資料後要做的事
    func requestData<D: Decodable>(offset: Int = 0,
                                   limit: Int,
                                   finish: @escaping (ResponseResult<D>) -> Void) {
        // MARK: 組合出要請求的 URL
        
        let path = NetworkConstants.baseUrl + NetworkConstants.APIPath.aqi.rawValue
        let apiKey = NetworkConstants.apiKey
        guard let url = URL(string: path + "?offset=\(offset)" + "&limit=\(limit)" + "&api_key=" + apiKey) else {
            finish(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // MARK: 確認有無錯誤
            
            guard error == nil else {
                finish(.failure(.unknownError(error!)))
                return
            }
            
            // MARK: 確認 statusCode 是否為 200
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                finish(.failure(.invalidResponse))
                return
            }
            
            // MARK: 確認是否成功用 JSONDecoder 解碼成我們要的結構
            
            let decoder = JSONDecoder()
            guard let data = data,
                  let results = try? decoder.decode(D.self, from: data) else {
                finish(.failure(.jsonDecodeFailed))
                return
            }
            
            // MARK: 都成功後，將解碼完的資料透過閉包 (Closure) 帶出來
            
            finish(.success(results))
            
        }.resume()
    }
}
