import UIKit

class MainView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let addCustomerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("고객 10명 추가", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(ViewController.addCustomerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("초기화", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.tintColor = .red
        return button
    }()
    
    let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "업무시간 -"
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .right
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:000"
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        return label
    }()
    
    func configUI() {
        let buttonStackView = UIStackView(arrangedSubviews: [addCustomerButton,resetButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        addSubview(buttonStackView)
        buttonStackView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor)
        
        let timeStackView = UIStackView(arrangedSubviews: [timeTitleLabel, timeLabel])
        timeStackView.axis = .horizontal
        timeStackView.distribution = .fillEqually
        timeStackView.spacing = 5
        addSubview(timeStackView)
        timeStackView.anchor(top: buttonStackView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10)
    }
}
