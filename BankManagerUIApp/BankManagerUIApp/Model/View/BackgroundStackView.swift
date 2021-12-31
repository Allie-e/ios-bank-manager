import UIKit

class BackgroundStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configueUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configueUI() {
        let waitingStatusStackView = CustomerStatusStackView()
        waitingStatusStackView.axis = .vertical
        waitingStatusStackView.distribution = .fillEqually
        addArrangedSubview(waitingStatusStackView)
        waitingStatusStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor)
        
        let workingStatusStackView = CustomerStatusStackView()
        workingStatusStackView.axis = .vertical
        workingStatusStackView.distribution = .fillEqually
        addArrangedSubview(workingStatusStackView)
        workingStatusStackView.anchor(top: topAnchor, left: waitingStatusStackView.rightAnchor, bottom: bottomAnchor)
    }
}
