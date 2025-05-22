import Foundation

// MARK: - User

struct User: Codable {
    let name: String
    let username: String
    let password: String
}

func loadUsersFromJSON() -> [User]? {
    let fileManager = FileManager.default
    guard let documentsDirectory = try? fileManager.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
    ) else {
        return nil
    }

    let fileURL = documentsDirectory.appendingPathComponent("admin_config.json")

    do {
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([User].self, from: data)
    } catch {
        print("Error reading JSON file: \(error)")
        return nil
    }
}

func saveUsersToJSON(users: [User]) {
    let fileManager = FileManager.default
    guard let documentsDirectory = try? fileManager.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
    ) else {
        return
    }

    let fileURL = documentsDirectory.appendingPathComponent("admin_config.json")

    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(users)
        try data.write(to: fileURL)
    } catch {
        print("Error saving to JSON file: \(error)")
    }
}
