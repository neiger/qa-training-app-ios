import Foundation

struct User: Codable {
    let name: String
    let username: String
    let password: String
}

func loadUsersFromJSON() -> [User]? {
    let fileManager = FileManager.default
    let documentsDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let fileURL = documentsDirectory.appendingPathComponent("admin_config.json")
    
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let users = try decoder.decode([User].self, from: data)
        return users
    } catch {
        print("Error reading JSON file: \(error)")
        return nil
    }
}

func saveUsersToJSON(users: [User]) {
    let fileManager = FileManager.default
    let documentsDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let fileURL = documentsDirectory.appendingPathComponent("admin_config.json")
    
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(users)
        try data.write(to: fileURL)
    } catch {
        print("Error saving to JSON file: \(error)")
    }
}
