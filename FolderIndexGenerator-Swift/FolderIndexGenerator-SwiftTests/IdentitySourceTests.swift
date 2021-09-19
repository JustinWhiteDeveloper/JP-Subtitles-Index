//
//  FolderIndexGenerator_SwiftTests.swift
//
//  Created by Justin White on 3/09/21.
//

import XCTest
@testable import FolderIndexGenerator_Swift


class IdentitySourceTests: XCTestCase {

    let bundleResourcesFolder: String = "/contents/Resources"

    func testIdentityFileWriter_ReadFromBundle() throws {
        
        //given
        let bundle = Bundle(for: type(of: self))
        let source = bundle.bundlePath + bundleResourcesFolder
        
        //when
        let identity: Identity = FolderIdentity(source: source)

        //then
        XCTAssertEqual(identity.description,
                       "{\"FolderA\":\"229424720232674\",\"FolderB\":\"229424720232675\"}")
    }
}
