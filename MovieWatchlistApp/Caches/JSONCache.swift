//
//  JSONCache.swift
//  MovieWatchlistApp
//
//  Created by Dennis Dimitrov on 27.02.22.
//

import Foundation

public protocol JSONOriginObj{
    typealias JSONSource = [String:Any]
    var json: JSONSource { get }
    init?(json: JSONSource)
}



public class JSONCache{
    public static let appDirCache = JSONCache()
    public let fileManager = FileManager()
    public let cachePath: String
    
    public var verbose: Bool = false
    
    enum JsonCacheError: Error{
        case creationError
        case notWrittable
    }
    
    init(storagePath: String? = nil){
        if let storagePath = storagePath{
            self.cachePath = storagePath
        }else{
            self.cachePath = fileManager.currentDirectoryPath + "/cache"
        }
    }
    
    func prepareCacheDir() throws{
        var isDir: ObjCBool = false
        if !fileManager.fileExists(atPath: cachePath, isDirectory: &isDir){
            do{
                try fileManager.createDirectory(at: URL.init(fileURLWithPath: cachePath), withIntermediateDirectories: false, attributes:  [:])
            }catch{
                throw JsonCacheError.creationError
            }
        }
    }
    
    private func sanatize(for id:String) -> String{
        return id.replacingOccurrences(of: ".", with: "_")
    }
    
    public func cachePath(for id: String) -> String{
        let safeId = self.sanatize(for: id)
        let targetPath = self.cachePath + "/" + safeId
        return targetPath
    }
    
    //json-like obj
    public func save(_ object: JSONOriginObj, as id: String)throws{
        try prepareCacheDir()
        let jsonData = try JSONSerialization.data(withJSONObject: object.json as Any, options: [])
        do{
            try? self.delete(id: id)
            let path = cachePath(for: id)
            try jsonData.write(to: URL(fileURLWithPath: path))
            if verbose{
                print("Debug: Cache created for \(id)")
            }
        }catch{
            throw JsonCacheError.notWrittable
        }
        
    }
    
    public func delete(id: String)throws{
        let url  = URL(fileURLWithPath: cachePath(for: id))
        try fileManager.removeItem(at: url)
    }
    
    public func isCacheValid(id: String, validityInterval: TimeInterval) -> Bool{
        if let modDate = cacheModDate(id: id){
            let age = Date().timeIntervalSince(modDate)
            if age < validityInterval{
                if verbose{
                    print("Debug: Valid cache for \(id)")
                }
                return true
            }else if verbose{
                print("Debug: Invalid cache for \(id)")
            }
        }
        return false
    }
    
    
    public func listCachedFile()throws -> [String]{
        return try fileManager.contentsOfDirectory(atPath: cachePath)
    }
    
    public func cacheModDate(id: String) -> Date?{
        let attributes = try? fileManager.attributesOfItem(atPath: cachePath(for: id))
        if let attributes = attributes, let modificationDate = attributes[.modificationDate] as? Date{
            return modificationDate
        }
        return nil
    }
    
    public func load<T: JSONOriginObj>(id: String, validityInterval: TimeInterval? = nil)-> T?{
        if let validityInterval = validityInterval, !isCacheValid(id: id, validityInterval: validityInterval){
            return nil
        }
        let path = cachePath(for: id)
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let json = json as? JSONOriginObj.JSONSource {
                return T(json: json)
            }else{
                return nil
            }
        }
        return nil
    }

}

