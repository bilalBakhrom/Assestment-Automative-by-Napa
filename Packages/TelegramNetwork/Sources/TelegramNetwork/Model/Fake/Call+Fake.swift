//
//  Call+Fake.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

extension Call {
    enum FakeDataURLResponder: FakeURLResponder {
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
                ])),
            User(
                id: "0xEE003",
                firstName: "Zoro",
                lastName: "Roronoa",
                profileImageURL: "https://avatars.mds.yandex.net/i?id=4c5f069c55ee210c59a21065d0ee97bd-5696782-images-thumbs&n=13",
                details: UserDetails(items: [
                    UserDetails.Content(type: .mobile, title: "mobile", data: "+447123423884"),
                    UserDetails.Content(type: .username, title: "username", data: "@piratehunter"),
                    UserDetails.Content(type: .bio, title: "bio", data: "Swordsman of Straw Hat Pirates"),
                ])),
            User(
                id: "0xEE004",
                firstName: "Usopp",
                lastName: "Sogekingu",
                profileImageURL: "https://avatars.mds.yandex.net/i?id=cb203934089f040f6682cd552e56cda0-7011710-images-thumbs&n=13",
                details: UserDetails(items: [
                    UserDetails.Content(type: .mobile, title: "mobile", data: "+447123423400"),
                    UserDetails.Content(type: .username, title: "username", data: "@sniper"),
                    UserDetails.Content(type: .bio, title: "bio", data: "Sniper of Straw Hat Pirates"),
                ])),
            User(
                id: "0xEE005",
                firstName: "Sanji",
                lastName: "Vinsumōku",
                profileImageURL: "https://avatars.mds.yandex.net/i?id=466571a79cc38ed6a3f235e254c56c6f-5865609-images-thumbs&n=13",
                details: UserDetails(items: [
                    UserDetails.Content(type: .mobile, title: "mobile", data: "+447123423433"),
                    UserDetails.Content(type: .username, title: "username", data: "@blackleg"),
                    UserDetails.Content(type: .bio, title: "bio", data: "Chief cook of Straw Hat Pirates"),
                ])),
            User(
                id: "0xEE006",
                firstName: "Nico",
                lastName: "Robin",
                profileImageURL: "https://pbs.twimg.com/media/Ctsh6AxVUAAfolP?format=jpg&name=medium",
                details: UserDetails(items: [
                    UserDetails.Content(type: .mobile, title: "mobile", data: "+447123423412"),
                    UserDetails.Content(type: .username, title: "username", data: "@devilchild"),
                    UserDetails.Content(type: .bio, title: "bio", data: "Archaelogist of Straw Hat Pirates"),
                ])),
           ]
        }()

        static func respond(to request: URLRequest) throws -> Data {
            let calls: [Call] = {
                [
                    Call(
                        id: 14,
                        date: "2022-09-19T16:10:00",
                        connection: .video,
                        type: .incoming,
                        incomingStatus: .accepted,
                        duration: 224,
                        user: users[5]),
                    Call(
                        id: 13,
                        date: "2022-09-19T16:10:00",
                        connection: .audio,
                        type: .outgoing,
                        duration: 100,
                        user: users[1]),
                    Call(
                        id: 12,
                        date: "2022-09-19T16:10:00",
                        connection: .audio,
                        type: .outgoing,
                        duration: 50,
                        user: users[1]),
                    Call(
                        id: 11,
                        date: "2022-09-19T16:10:00",
                        connection: .audio,
                        type: .incoming,
                        incomingStatus: .missed,
                        user: users[2]),
                    Call(
                        id: 10,
                        date: "2022-09-19T16:10:00",
                        connection: .video,
                        type: .outgoing,
                        user: users[0]),
                    Call(
                        id: 9,
                        date: "2022-09-18T20:00:00",
                        connection: .audio,
                        type: .incoming,
                        incomingStatus: .accepted,
                        duration: 40,
                        user: users[1]),
                    Call(
                        id: 8,
                        date: "2022-09-17T20:03:00",
                        connection: .video,
                        type: .incoming,
                        incomingStatus: .rejected,
                        user: users[2]),
                    Call(
                        id: 7,
                        date: "2022-09-17T08:05:00",
                        connection: .video,
                        type: .outgoing,
                        incomingStatus: .accepted,
                        duration: 400,
                        user: users[0]),
                    Call(
                        id: 6,
                        date: "2022-09-16T17:23:12",
                        connection: .audio,
                        type: .outgoing,
                        duration: 120,
                        user: users[3]),
                    Call(
                        id: 5,
                        date: "2022-09-16T15:15:00",
                        connection: .audio,
                        type: .incoming,
                        incomingStatus: .accepted,
                        user: users[4]),
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
