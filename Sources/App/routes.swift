import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let friendController = FriendController()
    try router.register(collection: friendController)
}
