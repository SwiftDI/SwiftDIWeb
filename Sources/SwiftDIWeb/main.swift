import Kitura
import LoggerAPI
import HeliumLogger
import KituraStencil
import SwiftDIHLP
import SwiftDIWebRepositories

HeliumLogger.use()

let router = Router()
router.setDefault(templateEngine: StencilTemplateEngine())

let gameRepository = InMemoryGameRepository()

let _ = GamesController(router: router, gameRepository: gameRepository)

Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
