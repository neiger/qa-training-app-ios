import Foundation

class LoginViewModel {
    var username: String = ""
    var password: String = ""
    
    private(set) var cachedUsers: [User]? = nil

    init() {
        preloadUsers()
    }

    private func preloadUsers() {
        DispatchQueue.global(qos: .utility).async {
            self.cachedUsers = loadUsersFromJSON()
        }
    }

    func login(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let users = self.cachedUsers ?? loadUsersFromJSON()
            let matchedUser = users?.first { $0.username == self.username && $0.password == self.password }
            DispatchQueue.main.async {
                completion(matchedUser != nil)
            }
        }
    }

    func registerNewUser(name: String, username: String, password: String) {
        var users = loadUsersFromJSON() ?? []
        let newUser = User(name: name, username: username, password: password)
        users.append(newUser)
        saveUsersToJSON(users: users)
        
        // Update the cached list so login sees the new user
        self.cachedUsers = users
    }

}

