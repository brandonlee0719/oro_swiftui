import SwiftUI

class MainRouter: ObservableObject {
    
    @Published var currentPage: Page = .home
    
}


enum Page {
    case home
    case liked
    case records
    case user
}
