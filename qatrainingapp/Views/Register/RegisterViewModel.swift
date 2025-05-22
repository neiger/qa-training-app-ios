// import Foundation
//
// class RegisterViewModel {
//
//    // Validation function
//    func validateInput(name: String?, username: String?, password: String?) -> Bool {
//        guard let name = name, !name.isEmpty,
//              let username = username, !username.isEmpty,
//              let password = password, !password.isEmpty else {
//            return false
//        }
//        return true
//    }
//
//    // Save user data to JSON
//    func saveUserToJSON(user: User) {
//        let fileURL = getDocumentsDirectory().appendingPathComponent("admin_config.json")
//
//        var users: [User] = []
//
//        // Read existing users
//        if let data = try? Data(contentsOf: fileURL),
//           let existingUsers = try? JSONDecoder().decode([User].self, from: data) {
//            users = existingUsers
//        }
//
//        // Add the new user
//        users.append(user)
//
//        // Save the updated list back to the file
//        if let newData = try? JSONEncoder().encode(users) {
//            do {
//                try newData.write(to: fileURL)
//                print("User saved successfully.")
//            } catch {
//                print("Failed to write JSON: \(error)")
//            }
//        }
//    }
//
//
//    private func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
// }
