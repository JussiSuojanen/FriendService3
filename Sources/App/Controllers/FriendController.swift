//
//  FriendController.swift
//  App
//
//  Created by Jussi Suojanen on 16/12/2018.
//

import Vapor

final class FriendController: RouteCollection {
    func boot(router: Router) throws {
        let friendRoutes = router.grouped("api", "friends")
        friendRoutes.get(use: index)
        friendRoutes.put(use: update)
        friendRoutes.delete(Int.parameter, use: delete)
        friendRoutes.post(use: create)
    }

    func create(_ req: Request) throws -> Future<Friend> {
        return try req
            .content
            .decode(Friend.self)
            .flatMap(to: Friend.self) { friend in
                return friend.save(on: req)
        }
    }

    /// Returns a list of all `Friend`s.
    func index(_ req: Request) throws -> Future<[Friend]> {
        return Friend
            .query(on: req)
            .all()
    }

    // Updates friend information to database
    func update(_ req: Request) throws -> Future<Friend> {
        return try req
            .content
            .decode(Friend.self)
            .flatMap(to: Friend.self) { friend in
            return friend.update(on: req)
        }
    }

    /// Deletes a parameterized `Friend`.
    func delete(_ req: Request) throws -> Future<Friend> {
        let friendId = try req.parameters.next(Int.self)
        return Friend
            .find(friendId, on: req)
            .unwrap(or: Abort(.notFound))
            .delete(on: req)
    }
}
