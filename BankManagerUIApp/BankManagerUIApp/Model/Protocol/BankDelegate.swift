protocol BankDelegate: AnyObject {
    func didEnqueueCustomer(customer: Customer)
}
