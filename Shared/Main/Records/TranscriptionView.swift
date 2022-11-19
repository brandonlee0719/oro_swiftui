//
//  TranscriptionView.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/19.
//

import SwiftUI
import UIKit
import AVFoundation
import Starscream

struct TranscriptionView: UIViewControllerRepresentable {
    var audioURL: URL
    func makeUIViewController(context: Context) -> TranscriptionViewController {
        let transcriptionVC = TranscriptionViewController()
        transcriptionVC.audioURL = audioURL
        return transcriptionVC
    }
    
    func updateUIViewController(_ uiViewController: TranscriptionViewController, context: Context) {
        
    }
}

class TranscriptionViewController: UIViewController  {
    
    var audioURL: URL!
    
    private let apiKey = "Token 712646679cb1fff69a40073e00b3d9fe7a0976b8"
    private let audioEngine = AVAudioEngine()
    
    private lazy var socket: WebSocket = {
        let url = URL(string: "wss://api.deepgram.com/v1/listen?encoding=linear16&sample_rate=48000&channels=1")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "Authorization")
        return WebSocket(request: urlRequest)
    }()
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let transcriptView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket.delegate = self
        socket.connect()
        setupView()
        startAnalyzingAudio()
    }
    
    private func setupView() {
        view.addSubview(transcriptView)
        NSLayoutConstraint.activate([
            transcriptView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            transcriptView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            transcriptView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            transcriptView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func startAnalyzingAudio() {
        print("audioURL:", self.audioURL as Any)
        let inputNode = audioEngine.inputNode
        let inputFormat = inputNode.inputFormat(forBus: 0)
        let outputFormat = AVAudioFormat(commonFormat: .pcmFormatInt16, sampleRate: inputFormat.sampleRate, channels: inputFormat.channelCount, interleaved: true)
        let converterNode = AVAudioMixerNode()
        let sinkNode = AVAudioMixerNode()
        
        audioEngine.attach(converterNode)
        audioEngine.attach(sinkNode)
        
        converterNode.installTap(onBus: 0, bufferSize: 1024, format: converterNode.outputFormat(forBus: 0)) { (buffer: AVAudioPCMBuffer!, time: AVAudioTime!) -> Void in
            if let data = self.toNSData(buffer: buffer) {
                self.socket.write(data: data)
            }
        }
        
        audioEngine.connect(inputNode, to: converterNode, format: inputFormat)
        audioEngine.connect(converterNode, to: sinkNode, format: outputFormat)
        audioEngine.prepare()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.record)
            try audioEngine.start()
        } catch {
            print(error)
        }

        //  let file = try! AVAudioFile(forReading: audioURL!)
        //  let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: 1, interleaved: false)

        //  let buf = AVAudioPCMBuffer(pcmFormat: format!, frameCapacity: 1024)
        //  try! file.read(into: buf!)

        //  // this makes a copy, you might not want that
        //  let floatArray = UnsafeBufferPointer(start: buf?.floatChannelData![0], count:Int(buf!.frameLength))
        //  var data = Data()
        //  for buf in floatArray {
        //      data.append(withUnsafeBytes(of: buf) { Data($0) })
        //  }
        //  self.socket.write(data: data)
        
    }
    
    private func toNSData(buffer: AVAudioPCMBuffer) -> Data? {
        let audioBuffer = buffer.audioBufferList.pointee.mBuffers
        return Data(bytes: audioBuffer.mData!, count: Int(audioBuffer.mDataByteSize))
    }
}

extension TranscriptionViewController: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
//            case .text(let text):
//                let jsonData = Data(text.utf8)
//                let response = try! jsonDecoder.decode(DeepgramResponse.self, from: jsonData)
//                let transcript = response.channel.alternatives.first!.transcript
//
//                if response.isFinal && !transcript.isEmpty {
//                    if transcriptView.text.isEmpty {
//                        transcriptView.text = transcript
//                    } else {
//                        transcriptView.text = transcriptView.text + " " + transcript
//                    }
//                }
//            case .error(let error):
//                print(error ?? "")
            case .connected(let headers):
//                isConnected = true
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
//                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let text):
                let jsonData = Data(text.utf8)
                let response = try! jsonDecoder.decode(DeepgramResponse.self, from: jsonData)
                let transcript = response.channel.alternatives.first!.transcript

                if response.isFinal && !transcript.isEmpty {
                    if transcriptView.text.isEmpty {
                        transcriptView.text = transcript
                    } else {
                        transcriptView.text = transcriptView.text + " " + transcript
                    }
                }
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
//                isConnected = false
                break
            case .error(let error):
//                isConnected = false
//                handleError(error)
                print(error ?? "")
        }
    }
}

struct DeepgramResponse: Codable {
    let isFinal: Bool
    let channel: Channel
    
    struct Channel: Codable {
        let alternatives: [Alternatives]
    }
    
    struct Alternatives: Codable {
        let transcript: String
    }
}
