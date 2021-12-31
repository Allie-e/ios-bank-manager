import UIKit

class CustomerStatusStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) hastitlenot been implemented")
    }
    
    convenience init(title: String, bgColor: UIColor) {
        self.init()
        configUI()
        configLayout()
        statusLabel.text = title
        statusLabel.backgroundColor = bgColor
    }
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private var customerListScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    var customerListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    
    func configUI() {
        axis = .vertical
        spacing = 8
        
        addArrangedSubview(statusLabel)
        addArrangedSubview(customerListScrollView)
        customerListScrollView.addSubview(customerListStackView)
    }
    
    func configLayout() {
        customerListScrollView.anchor(left: leftAnchor, right: rightAnchor)
        customerListStackView.anchor(top: customerListScrollView.topAnchor, left: customerListScrollView.leftAnchor, bottom: customerListScrollView.bottomAnchor, right: customerListScrollView.rightAnchor)
    }
}
