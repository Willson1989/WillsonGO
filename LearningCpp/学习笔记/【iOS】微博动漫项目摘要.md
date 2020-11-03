[TOC]



#### UIDevice.current.beginGeneratingDeviceOrientationNotifications( )的作用

UIDevice 类总是会发送各种各样的通知，用来反映设备的行为，其中就有监听设备朝向（横竖屏）的通知。

在监听这个通知之前，要调用 UIDevice.current.beginGeneratingDeviceOrientationNotifications 

结束监听的时候，要调用 UIDevice.current.endGeneratingDeviceOrientationNotifications()



#### UICollectionViewFlowLayout 的 sectionInsetReference

https://www.jianshu.com/p/f34e2a6a84dc

```swift
    @available(iOS 11.0, *)
    public enum SectionInsetReference : Int {

        case fromContentInset = 0

        case fromSafeArea = 1

        case fromLayoutMargins = 2
    }
```

安全区适配（safeArea），用于防止刘海屏遮挡collectionView的内容









Typically, you do not adopt this protocol in your own classes. When you present or dismiss a view controller, UIKit creates a transition coordinator object automatically and assigns it to the view controller’s [transitionCoordinator](apple-reference-documentation://ls%2Fdocumentation%2Fuikit%2Fuiviewcontroller%2F1619294-transitioncoordinator) property. That transition coordinator object is ephemeral and lasts for the duration of the transition animation.

You can use a transition coordinator object to perform tasks that are related to a transition but that are separate from what the animator objects are doing. During a transition, the animator objects are responsible for putting the new view controller content onscreen, but there may be other visual elements that need to be displayed too. For example, a presentation controller might want to animate the appearance or disappearance of decoration views that are separate from the view controller content. In that case, it uses the transition coordinator to perform those animations.

The transition coordinator works with the animator objects to ensure that any extra animations are performed in the same animation group as the transition animations. Having the animations in the same group means that they execute at the same time and can all respond to timing changes provided by an interactive animator object. These timing adjustments happen automatically and do not require any extra code on your part.

Using the transition coordinator to handle view hierarchy animations is preferred over making those same changes in the [viewWillAppear(_:)](apple-reference-documentation://ls%2Fdocumentation%2Fuikit%2Fuiviewcontroller%2F1621510-viewwillappear) or similar methods of your view controllers. The blocks you register with the methods of this protocol are guaranteed to execute at the same time as the transition animations. More importantly, the transition coordinator provides important information about the state of the transition, such as whether it was cancelled, to your animation blocks through the [UIViewControllerTransitionCoordinatorContext](apple-reference-documentation://ls%2Fdocumentation%2Fuikit%2Fuiviewcontrollertransitioncoordinatorcontext) object.

In addition to registering animations to perform during the transition, you can call the [notifyWhenInteractionEnds(_:)](apple-reference-documentation://ls%2Fdocumentation%2Fuikit%2Fuiviewcontrollertransitioncoordinator%2F1619292-notifywheninteractionends) method to register a block to clean up animations associated with an interactive transition. Cleaning up is particularly important when the user cancels a transition interactively. When a cancellation occurs, you need to return to the original view hierarchy state as it existed before the transition. 

Because the transition coordinator is in effect only during a transition, UIKit releases the object when the transition finishes and the final callback is made.