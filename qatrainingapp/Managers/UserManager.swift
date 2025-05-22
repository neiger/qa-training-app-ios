
import Foundation

class UserManager {
    // MARK: Internal

    static let shared: UserManager = .init()

    /// Load users from bundled JSON
    func loadUsersFromBundle() -> [User] {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let users = try JSONDecoder().decode([User].self, from: data)
                print("Loaded users from bundle: \(users)")
                return users
            } catch {
                print("Error decoding JSON from bundle: \(error)")
            }
        } else {
            print("admin_config.json not found in bundle")
        }
        return []
    }

    // MARK: Private

    private let fileName = "admin_config"
}
