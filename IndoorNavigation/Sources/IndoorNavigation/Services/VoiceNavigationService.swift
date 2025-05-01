import Foundation
import AVFoundation

class VoiceNavigationService {
    private let synthesizer = AVSpeechSynthesizer()
    private var isSpeaking = false
    
    func speakInstruction(_ instruction: NavigationInstruction) {
        guard !isSpeaking else { return }
        
        let utterance = AVSpeechUtterance(string: instruction.description)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        
        synthesizer.speak(utterance)
        isSpeaking = true
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
}

extension VoiceNavigationService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        isSpeaking = false
    }
} 