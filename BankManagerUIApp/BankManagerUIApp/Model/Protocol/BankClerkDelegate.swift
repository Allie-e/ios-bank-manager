protocol BankClerkDelegate: AnyObject {
    func bankClerkStartWork(waitingNumber: Int, task: String)
    func bankClerkFinishWork(waitingNumber: Int, task: String)
}
