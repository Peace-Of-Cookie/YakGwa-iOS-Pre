//
//  Scene.swift
//
//
//  Created by Kim Dongjoo on 6/21/24.
//

import UIKit

public protocol Scene {
    var viewController: UIViewController { get }
}

public extension Scene where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
}
