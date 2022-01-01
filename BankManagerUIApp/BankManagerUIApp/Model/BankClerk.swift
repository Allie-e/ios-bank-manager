import Foundation

class BankClerk {
    weak var delegate: BankClerkDelegate?
    
    func handleTask(of customer: Customer) {
        guard let task = customer.task?.name, let taskTime = customer.task?.processingTime else {
            return
        }
        
        delegate?.bankClerkStartWork(waitingNumber: customer.waitingNumber, task: task)
        Thread.sleep(forTimeInterval: taskTime)
        delegate?.bankClerkFinishWork(waitingNumber: customer.waitingNumber, task: task)
    }
}
