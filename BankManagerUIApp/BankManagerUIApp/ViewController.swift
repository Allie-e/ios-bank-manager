import UIKit

class ViewController: UIViewController {
    private let buttonStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonStackView()
    }
    
    func setButtonStackView() {
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        let addCustomerButton = UIButton(type: .system)
        addCustomerButton.setTitle("고객 10명 추가", for: .normal)
        addCustomerButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
        
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("초기화", for: .normal)
        resetButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
        resetButton.tintColor = .red

        buttonStackView.addArrangedSubview(addCustomerButton)
        buttonStackView.addArrangedSubview(resetButton)
        
        view.addSubview(buttonStackView)

        let safeArea = view.safeAreaLayoutGuide
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
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
