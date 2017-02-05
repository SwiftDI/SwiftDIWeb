import SwiftDIHLP
import Kitura

class RPSGameHistoryObserver: GameHistoryObserver {
    let response: RouterResponse

    init(response: RouterResponse) {
        self.response = response
    }

    func fetched(games: [Game]) {
        do {
            try response.render("games", context: ["games": games.map({GamePresenter(game: $0)})])
        } catch {
            response.status(.internalServerError).send("error")
        }
    }

    func fetched(game: Game?) {
        do {
            if let game = game {
                try response.render("game", context: ["game": GamePresenter(game: game)])
            } else {
                try response.status(.notFound).end()
            }
        } catch {
            response.status(.internalServerError).send("error")
        }
    }
}
