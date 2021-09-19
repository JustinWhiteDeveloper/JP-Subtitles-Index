//
//  Identity.swift
//  FolderIndexGenerator-Swift
//
//  Created by Justin White on 3/09/21.
//

import Foundation

protocol Identity: CustomStringConvertible {
    func toString() -> String
}

internal extension String {
    var integerHash : Int {
        return self.utf8.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
}

class FolderIdentity: Identity {
    private let source: String
    
    private var folderMap: [String:String] = [:]
    
    var description: String {
        return toString()
    }
    
    init(source: String) {
        self.source = source
        
        var isDirectory: ObjCBool = false
        
        FileManager.default.fileExists(atPath: source, isDirectory: &isDirectory)
        
        if !isDirectory.boolValue {
            print(Strings.noFolderError)
            return
        }
        
        do {
            let paths = try FileManager.default.contentsOfDirectory(atPath: source)

            var isSubdirectory: ObjCBool = false

            for path in paths where (path as NSString).pathExtension.isEmpty {
                
                FileManager.default.fileExists(atPath: source + "/" + path, isDirectory: &isSubdirectory)

                if !isSubdirectory.boolValue || path.contains(".") {
                    continue
                }
                
                folderMap[path] = "\(path.integerHash)"
            }
        }
        catch {
            print(error)
        }
    }
    
    func toString() -> String {
        
        //Note: can't just use dictionary description as the implementation can change at any time
        
        let quoteChar = "\""
        
        let value = folderMap.map { quoteChar + $0.0 + quoteChar + ":" + quoteChar + $0.1 + quoteChar}
            .sorted()
            .joined(separator: ",")
        
        return "{" + value  + "}"
    }
}
