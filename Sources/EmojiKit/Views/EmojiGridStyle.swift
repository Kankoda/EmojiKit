//
//  Emoji+Grid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-02.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to modify the visual style of the
/// ``EmojiGrid`` component.
///
/// You can apply the style by using the view style modifier
/// ``SwiftUI/View/emojiGridStyle(_:)``.
///
/// You can use the ``standard`` style, any other predefined
/// styles, like ``large`` or ``extraLarge``. You can modify
/// these style, and create completely custom styles as well.
///
/// When defining custom styles, make sure that the style is
/// adjusted for different platforms.
public struct EmojiGridStyle {
    
    /// Create a style with an individual font and item size.
    ///
    /// - Parameters:
    ///   - font: The font to use, by default `.title`.
    ///   - itemSize: The item size to use, by default `30`.
    ///   - itemSpacing: The grid item spacing, by default `5`.
    public init(
        font: Font? = .title,
        itemSize: CGFloat = 30,
        itemSpacing: CGFloat = 5
    ) {
        self.font = font
        self.itemSize = itemSize
        self.itemSpacing = itemSpacing
        self.items = [GridItem(
            .adaptive(minimum: itemSize),
            spacing: itemSpacing
        )]
    }
    
    /// Create a style with an identical font and item size.
    ///
    /// - Parameters:
    ///   - fontSize: The font size to use, by default `30`.
    ///   - itemSpacing: The grid item spacing, by default `5`.
    public init(
        fontSize: CGFloat = 30,
        itemSpacing: CGFloat = 5
    ) {
        self.init(
            font: .system(size: fontSize),
            itemSize: fontSize,
            itemSpacing: itemSpacing
        )
    }
    
    /// The font to use.
    public var font: Font?
    
    /// The grid item size to use.
    public var itemSize: CGFloat
    
    /// The grid item spacing.
    public var itemSpacing: CGFloat
    
    /// The grid items.
    public var items: [GridItem]
}

public extension EmojiGridStyle {
    
    /// This standard emoji grid style.
    ///
    /// You can set this style to affect the global default.
    static var standard: Self = {
        #if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
        Self.init()
        #elseif os(tvOS)
        Self.init(font: .largeTitle, itemSize: 80, itemSpacing: 10)
        #endif
    }()
    
    /// A small size emoji grid style.
    static let small = Self(fontSize: sizeBase)
    
    /// A medium size emoji grid style.
    static let medium = Self(fontSize: sizeBase + (1 * sizeStep))
    
    /// A large size emoji grid style.
    static let large = Self(fontSize: sizeBase + (2 * sizeStep))
    
    /// An extra large size emoji grid style.
    static let extraLarge = Self(fontSize: sizeBase + (3 * sizeStep))
    
    /// An extra, extra large size emoji grid style.
    static let extraExtraLarge = Self(fontSize: sizeBase + (4 * sizeStep))
}

extension EmojiGridStyle {
    
    static var sizeBase: Double {
        #if os(tvOS)
        80
        #elseif os(iOS) || os(visionOS)
        40
        #else
        30
        #endif
    }
    
    static var sizeStep: Double {
        #if os(macOS)
        5
        #else
        10
        #endif
    }
    
    static var spacingBase: Double {
        #if os(tvOS)
        10
        #else
        5
        #endif
    }
}


public extension View {

    /// Apply a ``EmojiGridStyle``.
    func emojiGridStyle(
        _ style: EmojiGridStyle
    ) -> some View {
        self.environment(\.emojiGridStyle, style)
    }
}

private extension EmojiGridStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: EmojiGridStyle = .standard
    }
}

public extension EnvironmentValues {

    var emojiGridStyle: EmojiGridStyle {
        get { self [EmojiGridStyle.Key.self] }
        set { self [EmojiGridStyle.Key.self] = newValue }
    }
}
