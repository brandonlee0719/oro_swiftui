import SwiftUI

class MainRouter: ObservableObject {
    
    @Published var currentPage: Page = .home
    
}


enum Page {
    case record
    case audiogram
    case folder
    case setting
}
