import Foundation

enum HomeFilterEnum : Int, CaseIterable {
    case sendResponse
    case newQuestion
    case rejectQuestion
    
    var title : String {
        switch self {
        case .sendResponse : return "답변 완료"
        case .newQuestion : return "새 질문"
        case .rejectQuestion : return "거절질문"
        }
    }
}
