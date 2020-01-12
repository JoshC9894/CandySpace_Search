import UIKit

enum ShimmerSize {
    case small
    case large
}

extension UIView {
    func startLoading(size: ShimmerSize) {
        if !subviews.contains(where: {$0.tag == 1001}) {
            let shimmerView = UIView(frame: self.bounds)
            shimmerView.tag = 1001
            shimmerView.layer.cornerRadius = 5.0
            shimmerView.backgroundColor = UIColor.white
            self.addSubview(shimmerView)

            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.clear, UIColor.white, UIColor.clear].map({ $0.cgColor })
            gradient.locations =  {
                switch size {
                case .small:
                    return [0, 0.5, 1]
                case .large:
                    return [0.4, 0.5, 0.6]
                }
            }()


            gradient.frame = self.bounds

            let radianAngle: CGFloat = {
                var angle: CGFloat = 0
                switch size {
                case .small:
                    angle = -40
                case .large:
                    angle = -70
                }
                return angle * CGFloat.pi / 180
            }()
            gradient.transform = CATransform3DMakeRotation(radianAngle, 0, 0, 1)
            shimmerView.layer.mask = gradient

            // Animate Gradient Shimmer
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.fromValue = -self.frame.width
            animation.toValue = self.frame.width
            animation.repeatCount = .infinity
            animation.duration = 2.0
            animation.isRemovedOnCompletion = false
            gradient.add(animation, forKey: nil)
        }
    }

    func stopLoading() {
        self.subviews.forEach { (subview) in
            if subview.tag == 1001 {
                subview.removeFromSuperview()
            }
        }
    }
}
