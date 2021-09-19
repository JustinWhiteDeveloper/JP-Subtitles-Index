//
//  ContentView.swift
//  FolderIndexGenerator-Swift
//
//  Created by Justin White on 3/09/21.
//

import SwiftUI

internal enum Sizing {
    static let small: CGFloat = 10.0
    
    static let defaultViewSize: CGSize = CGSize(width: 600, height: 400)
}

struct ContentView: View {
    
    @State private var folder: String = Strings.defaultFolderName
    
    var body: some View {
        
        HStack {
            Spacer()
                .frame(width: Sizing.small,
                       height: Sizing.small)
            VStack {
                FolderSelector(folder: $folder)
                    .padding(Sizing.small)
                
                Button(Strings.actionButton) {
                    
                    let folderNotSelected = folder.isEmpty || folder == Strings.defaultFolderName
                    
                    if folderNotSelected {
                        print(Strings.noFolderError)
                        return
                    }
                    
                    let writer = FolderIdentityFileWriter()
                    let identity = FolderIdentity(source: folder)
                    
                    writer.write(identity: identity, outputFolder: folder)
                    
                    NSWorkspace.shared.selectFile(nil,
                                                  inFileViewerRootedAtPath: folder)
                    
                    //reset afterwards
                    folder = Strings.defaultFolderName
                }

            }.padding(Sizing.small)
            
        }.frame(width: Sizing.defaultViewSize.width,
                height: Sizing.defaultViewSize.height,
                alignment: .center)
    }
}
