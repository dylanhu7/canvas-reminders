//
//  main.swift
//  canvas-reminders
//
//  Created by Dylan Hu on 9/22/22.
//

import Foundation
import ArgumentParser

@main
struct CanvasReminders: AsyncParsableCommand {
    @Argument(help: "Your Canvas API key")
    var canvasApiKey: String

    mutating func run() async throws {
        let canvasAPI = CanvasAPI(canvasApiKey: canvasApiKey)
        try await canvasAPI.getCourses()
    }
}
