//
//  ServerManagerRequestHandler.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import Alamofire

internal enum ServerRequestRouter: URLRequestConvertible{
    
    static var baseURLString:String{
        return "http://starlord.hackerearth.com/"
    }
    
    case getPlaylist
    
    

    var httpMethod:Alamofire.HTTPMethod {
        switch self {
        case .getPlaylist:
           return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPlaylist:
            return "\(ServerRequestRouter.baseURLString)"+"studio"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let URL = Foundation.URL(string: path)!
        var mutableURLRequest = URLRequest(url: URL)
        mutableURLRequest.httpMethod = httpMethod.rawValue
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        switch  self {
        case .getPlaylist:
            do{
            
                let encoding = URLEncoding.default
                return try encoding.encode(mutableURLRequest, with: nil)
            } catch {
                return mutableURLRequest
            }
        }
    }
}
