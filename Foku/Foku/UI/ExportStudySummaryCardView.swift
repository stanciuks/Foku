import AppKit
import SwiftUI
import UniformTypeIdentifiers

struct ExportStudySummaryCardView: View {
    @EnvironmentObject private var sessionManager: FocusSessionManager
    @AppStorage("foku.dailyGoalMinutes") private var dailyGoalMinutes = 60
    @State private var exportMessage = "Ready to export a local Markdown summary."

    private var summaryMarkdown: String {
        StudySummaryExportEngine.makeMarkdown(
            progress: sessionManager.progress,
            recentSessions: sessionManager.recentSessions,
            dailyGoalMinutes: dailyGoalMinutes,
            privacyModeTitle: sessionManager.privacyModeTitle
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Export study summary")
                .font(.headline)

            Text("Create a local Markdown summary of progress, recent sessions, subject activity, achievements, and the privacy note.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 10) {
                Button("Copy summary") {
                    copySummaryToClipboard()
                }

                Button("Save Markdown...") {
                    saveSummaryWithPanel()
                }
            }

            Text(exportMessage)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            VStack(alignment: .leading, spacing: 6) {
                Text("Preview")
                    .font(.caption)
                    .fontWeight(.semibold)

                ScrollView {
                    Text(summaryMarkdown)
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textSelection(.enabled)
                }
                .frame(height: 150)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.secondary.opacity(0.08))
                )
            }

            Text("Future monetization idea: one-click exports could become part of a student or Plus toolkit, while the core timer stays free.")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(.quaternary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func copySummaryToClipboard() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(summaryMarkdown, forType: .string)
        exportMessage = "Copied summary to clipboard."
    }

    private func saveSummaryWithPanel() {
        let markdown = summaryMarkdown
        let panel = NSSavePanel()

        panel.title = "Save Foku Study Summary"
        panel.message = "Choose where to save your local Markdown summary."
        panel.nameFieldStringValue = StudySummaryExportEngine.fileName()
        panel.canCreateDirectories = true

        if let markdownType = UTType(filenameExtension: "md") {
            panel.allowedContentTypes = [markdownType]
        } else {
            panel.allowedContentTypes = [.plainText]
        }

        panel.begin { response in
            guard response == .OK, let url = panel.url else {
                exportMessage = "Save cancelled."
                return
            }

            do {
                try markdown.write(
                    to: url,
                    atomically: true,
                    encoding: .utf8
                )

                exportMessage = "Saved: \(url.lastPathComponent)"
            } catch {
                exportMessage = "Could not save file: \(error.localizedDescription)"
            }
        }
    }
}
