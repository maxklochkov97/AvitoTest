//
//  File.swift
//  Avito
//
//  Created by Максим Клочков on 04.05.2022.
//

/*
import Foundation

public protocol Cachable {
    var fileName: String { get }
    func transform() -> Data
}

final public class Cacher {
    let destination: URL
    private let queue = OperationQueue()

    public enum CacheDestination {
        case temporary
        case atFolder(String)
    }

    // MARK: Initialization
    public init(destination: CacheDestination) {
        // Create the URL for the location of the cache resources
        switch destination {
        case .temporary:
            self.destination = URL(fileURLWithPath: NSTemporaryDirectory())
        case .atFolder(let folder):
            let documentFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            self.destination = URL(fileURLWithPath: documentFolder).appendingPathComponent(folder, isDirectory: true)
        }

        let fileManager = FileManager.default

        do {
            try fileManager.createDirectory(at: self.destination, withIntermediateDirectories: true, attributes: nil)
        }
        catch {
            fatalError("Unable to create cache URL: \(error)")
        }
    }

    // MARK

    public func persist(item: Cachable, completion: @escaping (_ url: URL) -> Void) {
            let url = destination.appendingPathComponent(item.fileName, isDirectory: false)

            // Create an operation to process the request.
            let operation = BlockOperation {
                do {
                    try item.transform().write(to: url, options: [.atomicWrite])
                } catch {
                    fatalError("Failed to write item to cache: \(error)")
                }
            }

            // Set the operation's completion block to call the request's completion handler.
            operation.completionBlock = {
                completion(url)
            }

            // Add the operation to the queue to start the work.
            queue.addOperation(operation)
        }
    }

*/



/*
final class Cache<Key: Hashable, Value> {
    
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    
    init(dateProvider: @escaping () -> Date = Date.init,
         entryLifetime: TimeInterval = 1 * 60 * 60) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
    }
    
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    
    func value(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            // Discard values that have expired
            removeValue(forKey: key)
            return nil
        }
        
        return entry.value
    }
    
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
}

private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) { self.key = key }
        
        override var hash: Int { return key.hashValue }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            
            return value.key == key
        }
    }
}

private extension Cache {
    final class Entry {
        let value: Value
        
        init(value: Value) {
            self.value = value
        }
    }
}

extension Cache {
    
    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                // If nil was assigned using our subscript,
                // then we remove any value for that key:
                removeValue(forKey: key)
                return
            }
            
            insert(value, forKey: key)
        }
    }
}

class ArticleLoader {
    typealias Handler = (Result<Article, Error>) -> Void
    
    private let cache = Cache<Article.ID, Article>()
    
    func loadArticle(withID id: Article.ID,
                     then handler: @escaping Handler) {
        if let cached = cache[id] {
            return handler(.success(cached))
        }
        
        performLoading { [weak self] result in
            let article = try? result.get()
            article.map { self?.cache[id] = $0 }
            handler(result)
        }
    }
}

final class Entry {
    let value: Value
    let expirationDate: Date
    
    init(value: Value, expirationDate: Date) {
        self.value = value
        self.expirationDate = expirationDate
    }
}
*/
