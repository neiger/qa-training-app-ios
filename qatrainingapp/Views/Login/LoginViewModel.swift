import Foundation

class LoginViewModel {
    var username: String = ""
    var password: String = ""

    func login(completion: @escaping (Bool) -> Void) {
        // Load users from the JSON file
        if let users = loadUsersFromJSON() {
            // Check if the entered credentials match any user
            if let user = users.first(where: { $0.username == username && $0.password == password }) {
                completion(true)
                return
            }
        }
        completion(false)
    }

    func registerNewUser(name: String, username: String, password: String) {
        var users = loadUsersFromJSON() ?? []

        // Create a new user and append it to the array
        let newUser = User(name: name, username: username, password: password)
        users.append(newUser)

        // Save the updated list of users back to the JSON file
        saveUsersToJSON(users: users)
    }
}
