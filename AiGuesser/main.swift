//
//  main.swift
//  AiGuesser
//
//  Created by Andreas Ink on 11/25/22.
//

import Foundation
import CoreImage

let mapleDiffusion = MapleDiffusion(saveMemoryButBeSlower: false)

func run() {
let arguments = CommandLine.arguments
    mapleDiffusion.initModels() { (p, s) -> () in
        
        
        let person = arguments[0]
        let prompt = arguments[1]
        mapleDiffusion.generate(prompt: prompt, negativePrompt: "", seed: Int.random(in: 1..<Int.max), steps: Int(20), guidanceScale: 7.5) { (cgim, p, s) -> () in
            if (cgim != nil) && p == 1 {
                do {
                    try cgim?.png?.write(to: URL(fileURLWithPath: "./images/\(person).png"))
                    
                } catch {
                }
            }
            
        }
    }
      
}
extension CGImage {
    var png: Data? {
        guard let mutableData = CFDataCreateMutable(nil, 0),
            let destination = CGImageDestinationCreateWithData(mutableData, "public.png" as CFString, 1, nil) else { return nil }
        CGImageDestinationAddImage(destination, self, nil)
        guard CGImageDestinationFinalize(destination) else { return nil }
        return mutableData as Data
    }
}
