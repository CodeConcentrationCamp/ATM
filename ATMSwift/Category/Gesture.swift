import UIKit
import ObjectiveC

// 手势回调闭包类型
public typealias GestureHandler = (UIGestureRecognizer) -> Void

// MARK: - UIGestureRecognizer 扩展
public extension UIGestureRecognizer {
    // 关联对象 Key
    private enum AssociatedKey {
        static var handler = "GestureRecognizer_Handler_Key"
    }
    
    // 存储回调闭包的属性（通过关联对象实现）
    private var gestureHandler: GestureHandler? {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.handler) as? GestureHandler
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.handler,
                newValue,
                .OBJC_ASSOCIATION_COPY_NONATOMIC
            )
        }
    }
    
    // 初始化后设置回调的方法（替代在 init 中设置）
    func setHandler(_ handler: @escaping GestureHandler) {
        // 绑定 target 为自身，action 为内部处理方法
        self.addTarget(self, action: #selector(handleGesture))
        // 存储闭包（此时 self 已完全初始化，可安全访问）
        self.gestureHandler = handler
    }
    
    // 内部处理方法
    @objc private func handleGesture() {
        gestureHandler?(self)
    }
}

// MARK: - UIView 扩展（快速添加手势）
public extension UIView {
    // 点击手势
    func addTapGesture(
        numberOfTaps: Int = 1,
        numberOfTouches: Int = 1,
        handler: @escaping GestureHandler
    ) {
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = numberOfTaps
        tap.numberOfTouchesRequired = numberOfTouches
        tap.setHandler(handler) // 初始化后设置回调
        addGestureRecognizer(tap)
    }
    
    // 长按手势
    func addLongPressGesture(
        minimumPressDuration: TimeInterval = 1.0,
        allowableMovement: CGFloat = 10,
        handler: @escaping GestureHandler
    ) {
        let longPress = UILongPressGestureRecognizer()
        longPress.minimumPressDuration = minimumPressDuration
        longPress.allowableMovement = allowableMovement
        longPress.setHandler(handler)
        addGestureRecognizer(longPress)
    }
    
    // 滑动手势
    func addSwipeGesture(
        direction: UISwipeGestureRecognizer.Direction = .right,
        handler: @escaping GestureHandler
    ) {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = direction
        swipe.setHandler(handler)
        addGestureRecognizer(swipe)
    }
    
    // 捏合手势
    func addPinchGesture(handler: @escaping GestureHandler) {
        let pinch = UIPinchGestureRecognizer()
        pinch.setHandler(handler)
        addGestureRecognizer(pinch)
    }
    
    // 旋转手势
    func addRotationGesture(handler: @escaping GestureHandler) {
        let rotation = UIRotationGestureRecognizer()
        rotation.setHandler(handler)
        addGestureRecognizer(rotation)
    }
}
