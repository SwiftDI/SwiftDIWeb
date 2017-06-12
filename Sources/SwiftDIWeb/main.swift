import Kitura
import LoggerAPI
import HeliumLogger
import KituraStencil

HeliumLogger.use()

let router = Router()
router.setDefault(templateEngine: StencilTemplateEngine())

let _ = GamesController(router: router)

Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
