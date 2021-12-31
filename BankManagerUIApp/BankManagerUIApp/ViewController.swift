import UIKit

class ViewController: UIViewController {
    private var timer = Timer()
    private var timerStatus: TimerStatus = .start
    private var startTime = Date()
    
    private let mainView = MainView()
    private let buttonStackView = ButtonStackView()
    private let timerStackView = TimerStackView()
    private let waitingLineStackView = CustomerStatusStackView(title: "대기중", bgColor: .systemGreen)
    private let workingLineStackView = CustomerStatusStackView(title: "업무중", bgColor: .systemIndigo)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        setMainView()
        setButtonStackView()
        setTimerStackView()
        setCustomerStatusStackView()
    }
    
    func setMainView() {
        view.addSubview(mainView)
        mainView.anchor(top: view.safeAreaLayoutGuide.topAnchor , left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }
    
    func setButtonStackView() {
        view.addSubview(buttonStackView)
        buttonStackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor)
    }
    
    func setTimerStackView() {
        view.addSubview(timerStackView)
        timerStackView.anchor(top: buttonStackView.bottomAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, paddingTop: 15)
    }
    
    func setCustomerStatusStackView() {
        let backgroundStackView = UIStackView()
        backgroundStackView.axis = .horizontal
        backgroundStackView.distribution = .fillEqually
        mainView.addSubview(backgroundStackView)
        backgroundStackView.anchor(top: timerStackView.bottomAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 15)
        
        backgroundStackView.addArrangedSubview(waitingLineStackView)
        backgroundStackView.addArrangedSubview(workingLineStackView)
    }
}



//MARK: - Associate Timer

extension ViewController {
    private enum TimerStatus {
        case start
        case stop
    }
    
    @objc func addCustomerButtonTapped() {
        switch timerStatus {
        case .start:
            timerStatus = .stop
            startTime = Date()
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
            DispatchQueue.main.async { [self] in
                for _ in 1...50 {
                    let dd = UILabel()
                    dd.text = "dqwe"
                    workingLineStackView.customerListStackView.addArrangedSubview(dd)
                }
            }

        case .stop:
            return
        }
    }
    
    @objc func resetButtonTapped() {
        timerStatus = .start
        timer.invalidate()
        resetTimerLabel()
    }
    
    @objc private func startTimer() {
        let totalTime = Date().timeIntervalSince(startTime)
        let (minute, second, milliSecond) = convertTime(totalTime)
        let formattedTime = formattedTime(minute, second, milliSecond)
        timerStackView.timerLabel.text = formattedTime
    }
    
    private func formattedTime(_ minute: Int, _ second: Int, _ milliSecond: Int) -> String {
        let formattedMinute = String(format:"%02d", minute)
        let formattedSecond = String(format:"%02d", second)
        let formattedMilliSecond = String(format:"%03d", milliSecond)
        let formattedTime = "\(formattedMinute):\(formattedSecond):\(formattedMilliSecond)"
        
        return formattedTime
    }
    
    private func convertTime(_ totalTime: Double) -> (Int, Int, Int) {
        let minute = (Int)(fmod((totalTime/60), 60))
        let second = (Int)(fmod(totalTime, 60))
        let milliSecond = (Int)((totalTime - floor(totalTime))*1000)
        
        return (minute, second, milliSecond)
    }
    
    private func resetTimerLabel() {
        timerStackView.timerLabel.text = "00:00:000"
    }
}































#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
extension UIViewController {
    private struct ViewControllerRepresentable: UIViewControllerRepresentable {
        private let viewController: UIViewController
        
        init(with viewController: UIViewController) {
            self.viewController = viewController
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // Not Use
        }
    }
    
    func toPreview() -> some View {
        ViewControllerRepresentable(with: self)
    }
}

#endif

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ViewControllerPreview: PreviewProvider {
    static let deviceNames = [
        "iPhone 12"
        
    ]
    
    static var previews: some View {
        ForEach(deviceNames, id: \.self) { deviceName in
            ViewController().toPreview()
                .previewDevice(.init(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
#endif
