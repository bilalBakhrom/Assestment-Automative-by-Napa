//
//  Call+Fake.swift
//  
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import Foundation

extension Call {
    enum FakeDataURLResponder: FakeURLResponder {
        static let users: [User] = {
           [
            User(
                id: "0xEE003",
                firstName: "Rose",
                lastName: "Bell",
                profileImageURL: "https://images.unsplash.com/photo-1501644898242-cfea317d7faf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
            User(
                id: "0xEE001",
                firstName: "John",
                lastName: "Thomas",
                profileImageURL: "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
            User(
                id: "0xEE002",
                firstName: "Teresa",
                lastName: "Simmons",
                profileImageURL: "https://images.unsplash.com/photo-1592621385612-4d7129426394?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
            User(
                id: "0xEE004",
                firstName: "Ricardo",
                lastName: "Matthews",
                profileImageURL: nil),
            User(
                id: "0xEE005",
                firstName: "Scott",
                lastName: "Tucker",
                profileImageURL: "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
           ]
        }()

        static func respond(to request: URLRequest) throws -> Data {
            let calls: [Call] = {
                [
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
