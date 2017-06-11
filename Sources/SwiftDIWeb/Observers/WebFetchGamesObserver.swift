import SwiftDIHLP
import Kitura

class WebFetchGamesObserver: FetchGamesObserver, FetchGameObserver {
    let response: RouterResponse

    init(response: RouterResponse) {
        self.response = response
    }

    func fetched(games: [Game]) {
        do {
            try response.render("games.stencil", context: ["games": games.map({GamePresenter(game: $0)})])
        } catch {
            response.status(.internalServerError).send("error")
        }
    }

    func fetched(game: Game) {
        do {
            try response.render("game.stencil", context: ["game": GamePresenter(game: game)])
        } catch {
            response.status(.internalServerError).send("error")
        }
    }

    func gameNotFound() {
        do {
            try response.status(.notFound).end()
        } catch {
            response.status(.internalServerError).send("error")
        }
    }
}
