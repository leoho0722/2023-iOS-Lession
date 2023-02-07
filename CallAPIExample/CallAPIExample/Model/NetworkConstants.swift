//
//  NetworkConstants.swift
//  CallAPIExample
//
//  Created by Leo Ho on 2023/2/3.
//

import Foundation

struct NetworkConstants {
    
    static let apiKey = "91a2fc2a-d55e-4ad8-a4cf-2bb982f66771"
    
    static let baseUrl = "https://"
    
    enum APIPath: String {
        
        case aqi = "data.epa.gov.tw/api/v2/aqx_p_432"
    }
    
    enum RequestError: Error {
        
        /// 無效的 URL
        case invalidURL
        
        /// 未知的錯誤
        case unknownError(Error)
        
        /// 無效的 Response
        case invalidResponse
        
        /// JSON 解碼失敗
        case jsonDecodeFailed
    }
}

typealias ResponseResult<D: Decodable> = Result<D, NetworkConstants.RequestError>
