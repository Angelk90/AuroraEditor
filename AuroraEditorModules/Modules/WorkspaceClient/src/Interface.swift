//
//  Interface.swift
//  AuroraEditorModules/WorkspaceClient
//
//  Created by Marco Carnevali on 16/03/22.
//

import Combine
import Foundation

// TODO: DOCS (Marco Carnevali)
public struct WorkspaceClient {

    public var folderURL: () -> URL?

    public var getFiles: AnyPublisher<[FileItem], Never>

    public var getFileItem: (_ id: String) throws -> FileItem

    /// callback function that is run when a change is detected in the file system.
    /// This usually contains a `reloadData` function.
    public static var onRefresh: () -> Void = {}
    public static var filter: String = "" {
        didSet { WorkspaceClient.onRefresh(); print("Text changed to \(WorkspaceClient.filter)") }
    }

    // For some strange reason, swiftlint thinks this is wrong?
    public init(
        folderURL: @escaping () -> URL?,
        getFiles: AnyPublisher<[FileItem], Never>,
        getFileItem: @escaping (_ id: String) throws -> FileItem
    ) {
        self.folderURL = folderURL
        self.getFiles = getFiles
        self.getFileItem = getFileItem
    }
    // swiftlint:enable vertical_parameter_alignment

    enum WorkspaceClientError: Error {
        case fileNotExist
    }
}
