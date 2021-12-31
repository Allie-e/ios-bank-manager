import UIKit

class BackgroundStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configUI() {
        let waitingStatusStackView = CustomerStatusStackView(title: "대기중", bgColor: .systemGreen)
        waitingStatusStackView.axis = .vertical
        waitingStatusStackView.distribution = .fill
        addArrangedSubview(waitingStatusStackView)
        waitingStatusStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor)
        
        let workingStatusStackView = CustomerStatusStackView(title: "업무중", bgColor: .systemBlue)
        workingStatusStackView.axis = .vertical
        workingStatusStackView.distribution = .fill
        addArrangedSubview(workingStatusStackView)
        workingStatusStackView.anchor(top: topAnchor, left: waitingStatusStackView.rightAnchor, bottom: bottomAnchor)
    }
}
