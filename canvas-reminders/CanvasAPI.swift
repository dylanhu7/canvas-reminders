//
//  CanvasAPI.swift
//  canvas-reminders
//
//  Created by Dylan Hu on 9/24/22.
//

import Foundation

struct CanvasAPI {
    var canvasApiKey: String
    init(canvasApiKey: String) {
        self.canvasApiKey = canvasApiKey
    }
    func getCourses() async throws {
        let url = URL(string: "https://canvas.instructure.com/api/v1/courses")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(canvasApiKey)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        // write json to file
        let fileURL = URL(fileURLWithPath: "courses.json")
        try JSONSerialization.data(withJSONObject: json).write(to: fileURL)
    }
}
