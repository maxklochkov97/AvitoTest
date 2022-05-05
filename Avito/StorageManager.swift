//
//  StorageManager.swift
//  Avito
//
//  Created by Максим Клочков on 05.05.2022.
//

import Foundation

class StorageManager {
  enum Const {
    static let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static let cachedDateKey = "CachedDate"
  }

  struct ServerWithDate: Codable {
    let server: Server
    let date: Date
  }

  func saveServer(_ server: Server) {
    let serverWithDate = ServerWithDate(server: server, date: Date())
    save(data: serverWithDate)
  }

  func loadServer() -> Server? {
    guard let serverWithDate: ServerWithDate = load()  else { return nil }

    let minute = Calendar.current.dateComponents([.minute], from: serverWithDate.date, to: Date()).minute

    if let minute = minute, minute < 60 {
      return serverWithDate.server
    } else {
      return nil
    }
  }

  func save<T: Encodable>(data: T) {
    let path = Const.path
      .appendingPathComponent("\(T.self).json")
    try? JSONEncoder().encode(data).write(to: path)
  }

  func load<T: Decodable>() -> T? {
    let path = Const.path
      .appendingPathComponent("\(T.self).json")
    if let data = try? Data(contentsOf: path) {
      return (try? JSONDecoder().decode(T.self, from: data))
    }
    return nil
  }
}
