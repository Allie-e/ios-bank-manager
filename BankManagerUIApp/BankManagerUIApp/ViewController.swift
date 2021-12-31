import UIKit

class ViewController: UIViewController {
    private var timer = Timer()
    private var timerStatus: TimerStatus = .start
    private var startTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainView)
    }
    
    lazy var mainView: MainView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let view = MainView(frame: frame)
        return view
    }()
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
        mainView.timeLabel.text = formattedTime
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
        mainView.timeLabel.text = "00:00:000"
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
