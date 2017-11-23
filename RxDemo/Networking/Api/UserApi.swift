//
//  UserApi.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import Foundation

import Moya

enum UserApi {
    case getUsers
}

extension UserApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://demo4184959.mockable.io")!
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        return .requestPlain
        
    }
    
    var headers: [String: String]? {
        return nil
    }
}
