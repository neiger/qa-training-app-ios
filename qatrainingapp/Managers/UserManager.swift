
import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private let fileName = "admin_config"
    
    // Load users from bundled JSON
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
}
