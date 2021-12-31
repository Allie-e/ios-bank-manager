import UIKit

class CustomerStatusStackView: UIStackView {
    private var statusLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) hastitlenot been implemented")
    }
    
    convenience init(title: String, bgColor: UIColor) {
        self.init()
        configUI()
        statusLabel.text = title
        statusLabel.backgroundColor = bgColor
    }
    
    func configUI() {
        statusLabel.font = .preferredFont(forTextStyle: .title1)
        statusLabel.textAlignment = .center
        statusLabel.textColor = .white
        addArrangedSubview(statusLabel)
        
        let customerListScrollView = UIScrollView()
        addArrangedSubview(customerListScrollView)
        customerListScrollView.anchor(top: statusLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        let customerListStackView = UIStackView()
        customerListStackView.axis = .vertical
        customerListStackView.distribution = .fill
        customerListScrollView.addSubview(customerListStackView)
        customerListStackView.anchor(top: customerListScrollView.topAnchor, left: customerListScrollView.leftAnchor, bottom: customerListScrollView.bottomAnchor, right: customerListScrollView.rightAnchor)
    }
    
}
