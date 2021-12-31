import UIKit

class CustomerLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(task: String, waitingNumber: Int) {
        self.init()
        configUI()
        setText(waitingNumber, task)
    }
    
    func configUI() {
        font = .preferredFont(forTextStyle: .title2)
        textAlignment = .center
    }
    
    func setText(_ waitingNumber: Int, _ task: String) {
        if task == BankTask.deposit.name {
            textColor = .systemPurple
        }
        
        text = "\(waitingNumber) - \(task)"
    }
}
