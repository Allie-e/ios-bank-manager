import UIKit

class ViewController: UIViewController {
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
