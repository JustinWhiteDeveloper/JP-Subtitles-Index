//
//  IdentityFileWriter.swift
//  FolderIndexGenerator-Swift
//
//  Created by Justin White on 3/09/21.
//

import Foundation

public enum IdentityFile {
    public static let fileName = "group.identity"
}

protocol IdentityFileWriter {
    func write(identity: Identity, outputFolder: String)
}

class FolderIdentityFileWriter: IdentityFileWriter {
    func write(identity: Identity, outputFolder: String) {
       
        let value = identity.description
        
        do {
            try value.write(toFile: outputFolder + "/" + IdentityFile.fileName,
                     atomically: true,
                     encoding: .utf8)
        }
        catch {
            print(error)
        }
    }
}
