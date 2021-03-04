import UIKit
import PlaygroundSupport

enum TrafficLightColors: String {
    case red
    case yellow
    case green
}

protocol TrafficLightState {
    var activeColor: TrafficLightColors { get }
    
    func next()
}

// MARK: - Traffic Light

class TrafficLight: TrafficLightState {
    var activeColor: TrafficLightColors
    private weak var delegate: MyViewController?
    
    init(vc: MyViewController) {
        self.delegate = vc
        self.activeColor = .red
        delegate?.redView.layer.opacity = 1.0
    }
    
    func next() {
        switch activeColor {
        case .red:
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.redView.layer.opacity = 0.2
                    self.delegate?.yellowView.layer.opacity = 1.0
                }
            }
            activeColor = .yellow
        case .yellow:
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.yellowView.layer.opacity = 0.2
                    self.delegate?.greenView.layer.opacity = 1.0
                }
            }
            activeColor = .green
        case .green:
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.greenView.layer.opacity = 0.2
                    self.delegate?.redView.layer.opacity = 1.0
                }
            }
            activeColor = .red
        }
    }
}


// MARK: - Main View Controller

class MyViewController : UIViewController {
    var redView = UIView()
    var yellowView = UIView()
    var greenView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        drawTrafficLight()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        launchTrafficLight()
    }
    

    private func drawTrafficLight() {
        view.addSubview(redView)
        view.addSubview(yellowView)
        view.addSubview(greenView)
        
        var offset = 0
        [redView, yellowView, greenView].forEach { (lightView) in
            let squareWidthHeight: Int = Int(view.frame.height/3)
            let redFrame = CGRect(
                x: (Int(view.frame.width) - squareWidthHeight)/2,
                y: offset,
                width: squareWidthHeight,
                height: squareWidthHeight
            )
            lightView.frame = redFrame
            lightView.layer.opacity = 0.2
            lightView.layer.masksToBounds = true
            lightView.layer.cornerRadius = CGFloat(squareWidthHeight/2)
            offset += squareWidthHeight
        }
        
        redView.backgroundColor = .red
        yellowView.backgroundColor = .yellow
        greenView.backgroundColor = .green
    }
    
    func launchTrafficLight() {
        let tfl = TrafficLight(vc: self)
        
        let queue = DispatchQueue(label: "com.queue.test", qos: .userInitiated)
        for i in 0...100 {
            queue.async {
                Thread.sleep(forTimeInterval: 1)
                print("Current iteration: \(i)")
                print("Before change active light: \(tfl.activeColor)")
                tfl.next()
                print("After change active light: \(tfl.activeColor)")
            }
        }
    }
}

PlaygroundPage.current.liveView = MyViewController()
