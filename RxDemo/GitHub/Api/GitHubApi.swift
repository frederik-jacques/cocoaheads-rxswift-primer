//
//  GitHubApi.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import Foundation

import Moya

enum GitHubApi {
    case getRepositories
    case search( query:String )
}

extension GitHubApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getRepositories:
            return "/repositories"
        case .search:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
            
        case .getRepositories:
            return .requestPlain
        case .search( let query ):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.default )
            
        }
        
    }
    
    // FIXME: ADD YOUR OWN GITHUB TOKEN :-)
    // 1. Go to GitHub
    // 2. Settings > Developer Settings > New oAuth app
    // 3. Paste your tt here
    var headers: [String: String]? {
        return [
            "Authorization" : "token [YOUR-TOKEN]"
        ]
    }
}
