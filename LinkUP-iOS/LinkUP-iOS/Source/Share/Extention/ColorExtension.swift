import SwiftUI

// MARK: - 다크모드 대응 색상 시스템
extension Color {
    // 배경 계층
    static let appBackground       = Color(UIColor.systemBackground)          // 최상위 배경
    static let appSecondaryBackground = Color(UIColor.secondarySystemBackground) // 카드/섹션 배경
    static let appGroupedBackground   = Color(UIColor.systemGroupedBackground)   // 그룹 배경
    static let appTertiaryBackground  = Color(UIColor.tertiarySystemBackground)  // 내부 중첩 배경

    // 텍스트
    static let appPrimaryText   = Color(UIColor.label)              // 기본 텍스트
    static let appSecondaryText = Color(UIColor.secondaryLabel)     // 서브 텍스트
    static let appPlaceholder   = Color(UIColor.placeholderText)    // placeholder

    // 구분선
    static let appSeparator = Color(UIColor.separator)

    // 입력 필드 배경 (라이트: 흰색, 다크: 다크그레이)
    static let appInputBackground = Color(UIColor.systemGray6)

    // 버튼 / 태그 비활성 배경
    static let appButtonInactive = Color(UIColor.systemGray5)
}
