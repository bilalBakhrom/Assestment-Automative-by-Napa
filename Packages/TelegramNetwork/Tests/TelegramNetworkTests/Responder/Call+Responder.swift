//
//  Call+Responder.swift
//  
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import Foundation
@testable import TelegramNetwork

extension Call {
    enum MockDataURLResponder: MockURLResponder {
        static let users: [User] = {
           [
            User(
                id: "0xEE001",
                firstName: "Nami",
                lastName: "Oda",
                profileImageURL: "https://avatars.mds.yandex.net/i?id=07852db8aee5fc5babed0b2af8942876-4458035-images-thumbs&n=13",
                details: UserDetails(items: [
                    UserDetails.Content(type: .mobile, title: "mobile", data: "+447123423114"),
                    UserDetails.Content(type: .username, title: "username", data: "@nameithief"),
                    UserDetails.Content(type: .bio, title: "bio", data: "Navigator of Straw Hat Pirates"),
                ])),
            User(
                id: "0xEE002",
                firstName: "Luffy",
                lastName: "Monkey D",
                profileImageURL: "https://images.unsplash.com/photo-1592547097938-7942b22df3db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8b25lJTIwcGllY2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                details: UserDetails(items: [
                    UserDetails.Content(type: .mobile, title: "mobile", data: "+447123423004"),
                    UserDetails.Content(type: .username, title: "username", data: "@strawhat"),
                    UserDetails.Content(type: .bio, title: "bio", data: "King of Pirates"),
                ]))
           ]
        }()

        static func respond(to request: URLRequest) throws -> Data {
            let calls: [Call] = {
                [
                    Call(
                        id: 4,
                        date: "2022-09-12T15:34:00",
                        connection: .video,
                        type: .incoming,
                        incomingStatus: .accepted,
                        duration: 560,
                        user: users[0]),
                    Call(
                        id: 3,
                        date: "2022-09-12T13:45:00",
                        connection: .video,
                        type: .outgoing,
                        incomingStatus: .missed,
                        user: users[0]),
                    Call(
                        id: 2,
                        date: "2022-09-12T11:25:00",
                        connection: .audio,
                        type: .incoming,
                        incomingStatus: .missed,
                        user: users[0]),
                    Call(
                        id: 1,
                        date: "2022-09-10T16:10:00",
                        connection: .audio,
                        type: .incoming,
                        incomingStatus: .missed,
                        user: users[0]),
                ]
            }()
            
            return try JSONEncoder().encode(calls)
        }
    }
}
