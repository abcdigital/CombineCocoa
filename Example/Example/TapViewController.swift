import UIKit
import Combine
import CombineCocoa

final class TapViewController: UIViewController {
    
    private let tapView = UIView()
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tapView.backgroundColor = .systemBlue
        tapView.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        view.addSubview(tapView)
        
        let tapGesture = UITapGestureRecognizer()
        tapView.addGestureRecognizer(tapGesture)
        
        cancellable = tapGesture.tapPublisher
            .handleEvents(
                receiveCancel: {
                    print("🟡 Publisher was cancelled")
                }
            )
            .sink { [weak self] _ in
                print("✅ Tap received")
                self?.tapView.backgroundColor = .random()
            }
    }
    
    deinit {
        print("🔴 TapViewController deinitialized")
    }
}

private extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0.2...1),
            green: .random(in: 0.2...1),
            blue: .random(in: 0.2...1),
            alpha: 1.0
        )
    }
}
