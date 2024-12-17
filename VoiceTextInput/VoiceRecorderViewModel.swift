//
//  VoiceRecorderViewModel.swift
//  borrame
//
//  Created by Javier Calatrava on 11/12/24.
//

import Foundation
//import AVFoundation
import Speech

class VoiceRecorderViewModel: ObservableObject {
    @Published var transcribedText: String = ""
    @Published var isRecording: Bool = false
    
    private var audioRecorder: AVAudioRecorder?
    private let audioSession = AVAudioSession.sharedInstance()
    private let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()
    
    var speechRecognizer: SFSpeechRecognizer?

    func startRecording(locale: Locale) {
        do {
            self.speechRecognizer = SFSpeechRecognizer(locale: locale)

            recognitionTask?.cancel()
            recognitionTask = nil

            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

            guard let recognizer = speechRecognizer, recognizer.isAvailable else {
                transcribedText = "Reconocimiento de voz no disponible para el idioma seleccionado."
                return
            }
            
            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
                self.recognitionRequest.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
            recognitionTask = recognizer.recognitionTask(with: recognitionRequest) { result, error in
                if let result = result {
                    self.transcribedText = result.bestTranscription.formattedString
                }
            }
            
            isRecording = true
        } catch {
            transcribedText = "Error al iniciar la grabación: \(error.localizedDescription)"
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest.endAudio()
        recognitionTask?.cancel()
        isRecording = false
    }
}

