import UIKit

class TimerStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let timerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "업무시간 -"
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .right
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:000"
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        return label
    }()
    
    func configUI() {
        axis = .horizontal
        distribution = .fillEqually
        spacing = 5
        
        addArrangedSubview(timerTitleLabel)
        addArrangedSubview(timerLabel)
    }
}
