import Foundation

class Bank {
    private var waitingLine = Queue<Customer>()
    let bankClerk = BankClerk()
    weak var delegate: BankDelegate?
    
    private let depositQueue = DispatchQueue(label: "depositQueue", attributes: .concurrent)
    private let loanQueue = DispatchQueue(label: "loanQueue")
    private let sequenceQueue = DispatchQueue(label: "sequenceQueue")
    private let workGroup = DispatchGroup()
    private let semaphore = DispatchSemaphore(value: 2)

    private var totalCustomer = 0
    
    func setWaitingLine() {
        for number in 1...10 {
            let customer = Customer(waitingNumber: number)
            waitingLine.enqueue(customer)
            delegate?.didEnqueueCustomer(customer: customer)
        }
    }

    private func dequeueWaitingLine() -> Customer? {
        return waitingLine.dequeue()
    }
    
    func start() {
        setWaitingLine()
        work()
    }
    
    private func work() {
        while waitingLine.isEmpty == false {
            guard let customer = dequeueWaitingLine() else {
                fatalError("unknown error")
            }
            
            switch customer.task {
            case .deposit:
                sequenceQueue.async { [self] in
                    depositQueue.async(group: workGroup) {
                        semaphore.wait()
                        bankClerk.handleTask(of: customer)
                        totalCustomer += 1
                        semaphore.signal()
                    }
                }
            case .loan:
                loanQueue.async(group: workGroup) { [self] in
                    bankClerk.handleTask(of: customer)
                    totalCustomer += 1
                }
            default:
                return
            }
        }
        workGroup.notify(queue: .main) {
            NotificationCenter.default.post(name: .finishWork, object: nil)
        }
    }
}
