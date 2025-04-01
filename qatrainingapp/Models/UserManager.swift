//import Foundation
//
//class UserManager {
//    private let userDefaults = UserDefaults.standard
//    private let userFileURL: URL
//
//    init() {
//        let fileManager = FileManager.default
//        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        userFileURL = directoryURL.appendingPathComponent("users.json")
//        ensureDefaultAdmin()
//    }
//
//    func ensureDefaultAdmin() {
//        if let _ = try? Data(contentsOf: userFileURL) {
//            return // El archivo ya existe
//        }
//        
//        let usersArray: [[String: String]] = [
//            ["name": "admin", "username": "admin", "password": "admin123"]
//        ]
//        saveUsers(usersArray)
//    }
//
//    func addUser(name: String, username: String, password: String) -> Bool {
//        var users = getUsers()
//        
//        if users.contains(where: { $0["username"] == username }) {
//            return false // Usuario ya existe
//        }
//
//        users.append(["name": name, "username": username, "password": password])
//        saveUsers(users)
//        return true
//    }
//
//    private func getUsers() -> [[String: String]] {
//        guard let data = try? Data(contentsOf: userFileURL),
//              let users = try? JSONSerialization.jsonObject(with: data) as? [[String: String]] else {
//            return []
//        }
//        return users
//    }
//
//    private func saveUsers(_ users: [[String: String]]) {
//        guard let data = try? JSONSerialization.data(withJSONObject: users, options: .prettyPrinted) else { return }
//        try? data.write(to: userFileURL)
//    }
//
//    func isValidUser(username: String, password: String) -> Bool {
//        return getUsers().contains { $0["username"] == username && $0["password"] == password }
//    }
//}
