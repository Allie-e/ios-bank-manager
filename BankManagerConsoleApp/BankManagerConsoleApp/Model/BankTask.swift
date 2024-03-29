import Foundation

enum BankTask: CaseIterable {
    case deposit
    case loan
    
    var name: String {
        switch self {
        case .deposit: return "예금"
        case .loan: return "대출"
        }
    }
    
    var processingTime: Double {
        switch self {
        case .deposit: return 0.7
        case .loan: return 1.1
        }
    }
}
