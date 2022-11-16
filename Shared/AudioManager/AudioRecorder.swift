
//  AudioRecorder.swift
//  ORO
//
//  Created by MAC on 2022/11/12.
//

import Foundation
import SwiftUI
import AVFoundation
import Combine
import FirebaseStorage

class AudioRecorder: NSObject,ObservableObject {
    
    override init() {
        super.init()
        fetchRecordings()
    }

    var fileURL: URL?

    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    var audioRecorder: AVAudioRecorder!
    
    var recordings = [Recording]()
    
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }

    var uploading = true {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
        self.fileURL = audioFilename

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()

            recording = true
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        recording = false
        
        uploadAudioToFirestore()
    }
    
    func fetchRecordings() {
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let storageRef = Storage.storage().reference()
        let folderRef = storageRef.child("\(LocalStorage.uidValue)/records")

        folderRef.listAll { (result, error) in
            if let error = error {
                print("\(error)")
            }
            if(result != nil) {
                for item in result!.items {
                    let audioURL = documentDirectory.appendingPathComponent("\(item.name)")
                    item.getData(maxSize: 1 * 1024 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("\(error)")
                        }
                        if let d = data {
                            do {
                                try d.write(to: audioURL)
                                let audioAsset = AVURLAsset.init(url: audioURL, options: nil)
                                let duration = audioAsset.duration
                                let durationInSeconds = CMTimeGetSeconds(duration)
                                
                                let recording = Recording(fileURL: audioURL, createdAt: getCreationDate(for: audioURL), duration: Float(durationInSeconds))
                                self.recordings.append(recording)
                            } catch {
                                print(error)
                            }
                            self.recordings.sort(by: { $1.createdAt.compare($0.createdAt) == .orderedAscending})
                            // self.objectWillChange.send(self)
                        }
                        self.uploading = false
                        self.objectWillChange.send(self)
                    }
                }
            }
        }
    }
    
    func deleteRecording(urlsToDelete: [URL]) {
        
        for url in urlsToDelete {
            print(url)
            do {
               try FileManager.default.removeItem(at: url)
            } catch {
                print("File could not be deleted!")
            }
        }
        
        fetchRecordings()
    }

    func uploadAudioToFirestore() {
        
        uploading = true
        
        let storageRef = Storage.storage().reference()
                
        let localfile = self.fileURL ?? URL(string: "")
        
        let fileRef = storageRef.child("\(LocalStorage.uidValue)/records/\(self.fileURL!.lastPathComponent)")
        
        fileRef.putFile(from: localfile!, metadata: nil) { metaData, err in
            guard metaData != nil else { return }

            if let err = err {
                print(err.localizedDescription)
                return
            }

            fileRef.downloadURL { (url, err) in
                guard let downloadUrl = url else { return }

                print(downloadUrl)
                self.fetchRecordings()
            }

        }
    }
    
}
