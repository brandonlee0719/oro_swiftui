import SwiftUI

class MainRouter: ObservableObject {
    
    @Published var currentPage: Page = .record
    
}


enum Page {
    case record
    case audiogram
    case folder
    case setting
}
