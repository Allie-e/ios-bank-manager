import UIKit

class MainView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let addCustomerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("고객 10명 추가", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("고객 10명 추가", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.tintColor = .red
        return button
    }()
    
    func setButtonStackView() {
        let buttonStackView = UIStackView(arrangedSubviews: [addCustomerButton,resetButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        buttonStackView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, right: safeAreaLayoutGuide.rightAnchor)
    }
}
