//
//  ProjectNavigatorToolbarBottom.swift
//  AuroraEditor
//
//  Created by TAY KAI QUAN on 23/7/22.
//

import SwiftUI
import WorkspaceClient

struct ProjectNavigatorToolbarBottom: View {
    @Environment(\.controlActiveState)
    private var activeState

    @ObservedObject
    var workspace: WorkspaceDocument

    @State
    var filter: String = ""

    var body: some View {
        HStack(spacing: 10) {
            addNewFileButton
                .frame(width: 20)
                .padding(.leading, 10)
            ZStack {
                Color.init(red: 0.7, green: 0.7, blue: 0.7, opacity: activeState == .inactive ? 0.25 : 0.5)
                HStack {
                    sortButton
                    TextField("Filter", text: $filter)
                        .textFieldStyle(.plain)
                        .font(.system(size: 12))
                }.onChange(of: filter, perform: { WorkspaceClient.filter = $0 })
            }
            .cornerRadius(7)
            .overlay {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(Color.init(red: 0.5, green: 0.5, blue: 0.5), lineWidth: 0.5)
            }
            .padding([.top, .bottom], 4)
            .padding(.leading, -8)
            .padding(.trailing, 5)
        }
        .frame(height: 29, alignment: .center)
        .frame(maxWidth: .infinity)
        .overlay(alignment: .top) {
            Divider()
        }
    }

    private var addNewFileButton: some View {
        Menu {
            Button("Add File") {
                guard let folderURL = workspace.workspaceClient?.folderURL(),
                      let root = try? workspace.workspaceClient?.getFileItem(folderURL.path) else { return }
                root.addFile(fileName: "untitled") // TODO: use currently selected file instead of root
            }
            Button("Add Folder") {
                guard let folderURL = workspace.workspaceClient?.folderURL(),
                      let root = try? workspace.workspaceClient?.getFileItem(folderURL.path) else { return }
                // TODO: use currently selected file instead of root
                root.addFolder(folderName: "untitled")
            }
        } label: {
            Image(systemName: "plus")
        }
        .menuStyle(.borderlessButton)
        .menuIndicator(.hidden)
        .frame(maxWidth: 30)
        .opacity(activeState == .inactive ? 0.45 : 1)
    }

    private var sortButton: some View {
        Menu {
            Button {
                workspace.sortFoldersOnTop.toggle()
            } label: {
                Text(workspace.sortFoldersOnTop ? "Alphabetically" : "Folders on top")
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
        .menuStyle(.borderlessButton)
        .frame(maxWidth: 30)
        .opacity(activeState == .inactive ? 0.45 : 1)
    }
}
