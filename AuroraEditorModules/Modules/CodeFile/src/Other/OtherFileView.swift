//
//  OtherFileView.swift
//  
//
//  Created by Shibo Tong on 10/7/2022.
//

import SwiftUI
import QuickLookUI

/// A SwiftUI Wrapper for `QLPreviewView`
/// Mainly used for other unsupported files
/// ## Usage
/// ```swift
/// OtherFileView(otherFile)
/// ```
public struct OtherFileView: NSViewRepresentable {

    private var otherFile: CodeFileDocument

    /// Initialize the OtherFileView
    /// - Parameter otherFile: a file which contains URL to show preview
    public init(
        _ otherFile: CodeFileDocument
    ) {
        self.otherFile = otherFile
    }

    public func makeNSView(context: Context) -> QLPreviewView {
        let qlPreviewView = QLPreviewView()
        if let previewItemURL = otherFile.previewItemURL {
            qlPreviewView.previewItem = previewItemURL as QLPreviewItem
        }
        return qlPreviewView
    }

    /// Update preview file when file changed
    public func updateNSView(_ nsView: QLPreviewView, context: Context) {
        if let previewItemURL = otherFile.previewItemURL {
            // TODO: fix SIGABRT bug when window closed with image tab open
            nsView.previewItem = previewItemURL as QLPreviewItem
        }

    }

}
