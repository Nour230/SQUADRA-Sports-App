import Reachability
import Foundation

class NetworkManager {
    static func isInternetAvailable() -> Bool {
        do {
            let reachability = try Reachability()
            return reachability.connection != Reachability.Connection.none
        } catch {
            print("Unable to create Reachability instanc")
            return false
        }
    }
}
