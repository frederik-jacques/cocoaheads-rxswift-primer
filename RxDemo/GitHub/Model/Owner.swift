//
//  Owner.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import Foundation

struct Owner:Codable {
    
    enum CodingKeys:String, CodingKey {
        
        case login
        case id
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        
    }
    
    // MARK: - Properties
    // MARK: Public Properties
    let login:String
    let id:Int
    let avatarUrl:String
    let gravatarId:String
    let url:String
    let htmlUrl:String
    let followersUrl:String
    let followingUrl:String
    let gistsUrl:String
    let starredUrl:String
    let subscriptionsUrl:String
    let organizationsUrl:String
    let reposUrl:String
    let eventsUrl:String
    let receivedEventsUrl:String
    let type:String
    let siteAdmin:Bool
    
    // MARK: Private Properties
    
    // MARK: - Life-cycle methods
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container( keyedBy: CodingKeys.self )
        
        self.id = try container.decode( Int.self, forKey: .id )
        self.login = try container.decode( String.self, forKey: .login )
        self.avatarUrl = try container.decode( String.self, forKey: .avatarUrl )
        self.gravatarId = try container.decode( String.self, forKey: .gravatarId )
        self.url = try container.decode( String.self, forKey: .url )
        self.htmlUrl = try container.decode( String.self, forKey: .htmlUrl )
        self.followersUrl = try container.decode( String.self, forKey: .followersUrl )
        self.followingUrl = try container.decode( String.self, forKey: .followingUrl )
        self.gistsUrl = try container.decode( String.self, forKey: .gistsUrl )
        self.starredUrl = try container.decode( String.self, forKey: .starredUrl )
        self.subscriptionsUrl = try container.decode( String.self, forKey: .subscriptionsUrl )
        self.organizationsUrl = try container.decode( String.self, forKey: .organizationsUrl )
        self.reposUrl = try container.decode( String.self, forKey: .reposUrl )
        self.eventsUrl = try container.decode( String.self, forKey: .eventsUrl )
        self.receivedEventsUrl = try container.decode( String.self, forKey: .receivedEventsUrl )
        self.type = try container.decode( String.self, forKey: .type )
        self.siteAdmin = try container.decode( Bool.self, forKey: .siteAdmin )
        
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    

    
}
