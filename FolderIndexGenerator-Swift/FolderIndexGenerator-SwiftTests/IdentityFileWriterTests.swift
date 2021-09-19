//
//  FolderIndexGenerator_SwiftTests.swift
//  FolderIndexGenerator-SwiftTests
//
//  Created by Justin White on 3/09/21.
//

import XCTest
@testable import FolderIndexGenerator_Swift

class IdentityFileWriterTests: XCTestCase {

    let bundleResourcesFolder: String = "/contents/Resources"

    override func setUp() {
        let source = "./" + IdentityFile.fileName
        
        do {
            if FileManager.default.fileExists(atPath: source) {
                try FileManager.default.removeItem(atPath: source)
            }
        }
        catch {
            print(error)
            XCTFail()
        }
    }
    
    func testIdentityFileWriter_WriteToBundle() throws {
        
        //given
        let bundle = Bundle(for: type(of: self))
        let source = bundle.bundlePath + bundleResourcesFolder
        let identity: Identity = FolderIdentity(source: source)

        let writer: IdentityFileWriter = FolderIdentityFileWriter()
        
        //when
        writer.write(identity: identity, outputFolder: "./")
        
        //then
        XCTAssertTrue(FileManager.default.fileExists(atPath: IdentityFile.fileName))
    }
}
