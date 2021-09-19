//
//  FolderSelector.swift
//

import Foundation
import SwiftUI

struct FolderSelector: View {
    
    @Binding var folder: String
    
    var body: some View {
        Button(folder) {
            self.selectFolder()
        }
    }
    
    func selectFolder() {
        let folderChooserPoint = CGPoint(x: 0, y: 0)
        let folderChooserSize = CGSize(width: 500, height: 600)
        let folderChooserRectangle = CGRect(origin: folderChooserPoint, size: folderChooserSize)
        let folderPicker = NSOpenPanel(contentRect: folderChooserRectangle,
                                       styleMask: .utilityWindow,
                                       backing: .buffered,
                                       defer: true)

        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = true
        folderPicker.canDownloadUbiquitousContents = true
        folderPicker.canResolveUbiquitousConflicts = true

        folderPicker.begin { response in
            if response == .OK,
               let pickedFolder = folderPicker.urls.first {
                folder = pickedFolder.path
            }
        }
    }
}
