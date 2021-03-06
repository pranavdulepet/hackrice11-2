//
//  DemosCustom.swift
//  PoliceRecorder
//
//  Created by Pranav on 9/18/21.
//
 
import SwiftUI
import Combine
import Speech
import SwiftSpeech
 
public extension SwiftSpeech.Demos.Basic{
    
    struct BasicCustom : View {
        
        var sessionConfiguration: SwiftSpeech.Session.Configuration
        
        @State var text = ""
        @State var recording: HomeView = HomeView(record: true)
        @State var msg: TextContacts = TextContacts()

        
        public init(sessionConfiguration: SwiftSpeech.Session.Configuration) {
            self.sessionConfiguration = sessionConfiguration
        }
        
        public init(locale: Locale = .current) {
            self.init(sessionConfiguration: SwiftSpeech.Session.Configuration(locale: locale))
        }
        
        public init(localeIdentifier: String) {
            self.init(locale: Locale(identifier: localeIdentifier))
        }
        
        public var body: some View {
 
                VStack(spacing: 35.0) {
                    
                    let nonPoliceKeywords = ["No means no", "I'm uncomfortable", "Leave me alone"]
                    let policeKeywords = ["Gun", "Tase", "Hands Up", "I can't breathe", "Hurts"]
                    
                    Text(text)
                        .font(.system(size: 20, weight: .thin, design: .default))
                    SwiftSpeech.RecordButton.RecordButtonCustom()
                        .swiftSpeechToggleRecordingOnTap(sessionConfiguration: sessionConfiguration, animation: .spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))
                        .onRecognizeLatest(update: $text)
                    
                        .onChange(of: text){ element in
                            if nonPoliceKeywords.contains(element){
                                msg.sendText()
                            }
                            if policeKeywords.contains(element){
                                msg.sendText()
                            }
                        }
                    
                    NavigationLink(destination: HomeView(record: true), isActive: .constant(text.lowercased().range(of: "record audio") != nil)) {
                    }.onTapGesture {
                        self.recording.startRecording()
                    }
                    
                    NavigationLink(destination: CameraView(), isActive: .constant(text.lowercased().range(of: "record video") != nil)) {
                    }
                    
                       /*.onChange(of: text) {
                            element in
                            
                            
                            /*if element.lowercased().range(of: "record audio") != nil {
                                recording.startRecording()
                                NavigationLink(destination: HomeView()) { }
                            }*/
                            if element.lowercased().range(of: "record video") != nil {
                                //recording.startRecording()
                                NavigationLink(destination: CameraView()) { }
                            }
                            if nonPoliceKeywords.contains(element){
                                
                            }
                            if policeKeywords.contains(element){
                                
                            }
                            
                            
                        }*/
                            
                    
                }.onAppear {
                    SwiftSpeech.requestSpeechRecognitionAuthorization()
                    
                    

                }
            
        }
        
    }
}
