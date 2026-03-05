//
//  ContentView.swift
//  FoundationModelsExample7SamplingRandom
//
//  Created by Quanpeng Yang on 3/5/26.
//

import SwiftUI
import FoundationModels

struct ContentView: View {
    @State private var response = ""

    var body: some View {
        VStack {
            Button("Send") {
                let prompt = "Write a one sentence joke"
                let session = LanguageModelSession()
                let options = GenerationOptions(sampling: .random(top:5), temperature: 0.3)

                if !session.isResponding {
                    Task {
                        do {
                            let answer = try await session.respond(to: prompt, options: options)
                            response = answer.content
                        } catch {
                            response = "Error accessing the model: \(error)"
                        }
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Text(response)
                .font(.system(size: 18))
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
