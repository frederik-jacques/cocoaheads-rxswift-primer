//
//  Repository.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import Foundation

struct Repository:Codable {
    
    // MARK: - Properties
    // MARK: Public Properties
    
    enum CodingKeys:String, CodingKey {
        
        case id
        case owner
        case name
        case fullName = "full_name"
        case privateKey = "private"
        case fork
        case url
        case htmlUrl = "html_url"
        
    }
    
    let id:Int
    let owner:Owner
    let name:String
    let fullName:String
    let privateKey:Bool
    let fork:Bool
    let url:String
    let htmlUrl:String
    
    // MARK: Private Properties
    
    // MARK: - Life-cycle methods
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container( keyedBy: CodingKeys.self )

        self.id = try container.decode( Int.self, forKey: .id )
        self.owner = try container.decode( Owner.self, forKey: .owner )
        self.name = try container.decode( String.self, forKey: .name )
        self.fullName = try container.decode( String.self, forKey: .fullName )
        self.privateKey = try container.decode( Bool.self, forKey: .privateKey )
        self.fork = try container.decode( Bool.self, forKey: .fork )
        self.url = try container.decode( String.self, forKey: .url )
        self.htmlUrl = try container.decode( String.self, forKey: .htmlUrl )
        
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    

    
}
