import UIKit

class ButtonStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let addCustomerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("고객 10명 추가", for: .normal)
        button.addTarget(self, action: #selector(ViewController.addCustomerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("초기화", for: .normal)
        button.tintColor = .red
        let selector = #selector(ViewController.resetButtonTapped)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }()
    
    func configUI() {
        axis = .horizontal
        distribution = .fillEqually
        
        addArrangedSubview(addCustomerButton)
        addArrangedSubview(resetButton)
    }
}
