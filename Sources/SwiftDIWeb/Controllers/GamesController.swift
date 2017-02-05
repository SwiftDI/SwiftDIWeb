import Kitura
import SwiftDIHLP
import Foundation

final class GamesController {
    let gameRepository: GameRepository

    init(router: Router, gameRepository: GameRepository) {
        self.gameRepository = gameRepository
        createRoutes(router: router)
    }

    private func createRoutes(router: Router) {
        router.all("/games", middleware: BodyParser())
        router.get("/games", handler: index)
        router.get("/games/new", handler: new)
        router.get("/games/:gameId", handler: show)
        router.post("/games", handler: create)
    }

    private func index(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }

        FetchGamesUseCase(observer: RPSGameHistoryObserver(response: response),
                          repo: gameRepository)
            .execute()
    }

    private func new(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        try response.render("newGame", context: [:])
    }

    private func show(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }

        guard let id = request.parameters["gameId"] else { return }
        guard let uuid = UUID(uuidString: id) else {
            try response.status(.badRequest).end()
            return
        }

        FetchGameByIdUseCase(id: uuid,
                             observer: RPSGameHistoryObserver(response: response),
                             repo: gameRepository)
            .execute()
    }

    private func create(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }

        guard let values = request.body else {
            try response.status(.badRequest).end()
            return
        }

        guard case .urlEncoded(let body) = values else {
            try response.status(.badRequest).end()
            return
        }

        if let p1 = body["player1"], let p2 = body["player2"] {
            PlayUseCase(p1: p1,
                        p2: p2,
                        observer: RPSGameObserver(response: response),
                        repo: gameRepository)
                .execute()
        }
    }
}