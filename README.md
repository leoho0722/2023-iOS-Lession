# 2023 年寒假 iOS 課程規劃

[課程 Sample Code (GitHub)](https://github.com/leoho0722/2023-iOS-Lession)

作業繳交方式：上傳到你的 GitHub／GitLab，然後把 Git Repo 網址給我

## (1/16) Palette

- [1/16 Teams 課程錄影 Part1](https://o365nutc.sharepoint.com/:v:/s/msteams_ed6098/EWtBNr2yDRZAhKSHrsHVWCkBAS26AbKGK5rG2HtIX5xBcw?e=dRGw8t)
- [1/16 Teams 課程錄影 Part2](https://o365nutc.sharepoint.com/:v:/s/msteams_ed6098/EScgOtjVqslLgf4zZxotSqsB3xLkhxt14yPyHjTmfEh3Iw?e=342Sa9)
- [1/16 Teams 課程錄影 Part3](https://o365nutc.sharepoint.com/:v:/s/msteams_ed6098/EfCjwum0s3lBiLnQI2J2N8IBbbxSJ16IdeCEmN8fo_8Dig?e=H60eAd)
- [1/16 Teams 課程錄影 Part4](https://o365nutc.sharepoint.com/:v:/s/msteams_ed6098/EfCjwum0s3lBiLnQI2J2N8IBbbxSJ16IdeCEmN8fo_8Dig?e=H60eAd)

### 會用到的技能

* UIView
* UITextField
* UISlider
* UIStackView
* UIAlertController
* UITapGestureRecognizer
* UIColor
* Auto Layout
* guard let
* switch case
* Closure

### 作業

* 讓整個畫面的背景，也可以跟著變換顏色
* 幫 View 新增黑色邊框，並將邊框寬設為 2
* 當輸入超過 255 時，也要讓 View 的背景色變回預設值 (UIColor.lightGray)，整個畫面的背景色也要變回預設值 (UIColor.white)
* 讓 RGB 各顏色的 Slider 能隨著現在的數值來變換顏色

## (1/17) Message Board Part 1

- [1/17 Teams 課程錄影 Part1](https://o365nutc.sharepoint.com/:v:/s/msteams_ed6098/EblUabEINYVOu1NQQoUmkgkBlB0Da_2zQOPHA4SHR6zj7w?e=4iO6b1)
- [1/17 Teams 課程錄影 Part2](https://o365nutc.sharepoint.com/:v:/s/msteams_ed6098/ETryn1uK7T5MvYVRkzCmYSgBEu64ntZg3ixFlrBajtIK0w?e=JFe3fs)

### 會用到的技能

* UILabel
* UITextField
* UITextView
* UIButton
* UITableView
* UITableView Cell
* UIAlertController
* UITapGestureRecognizer
* Auto Layout
* Closure
* struct

### 作業

* 新增「更新動作」在「左滑操作」裡
* 在左滑、右滑的 UI 上，新增圖片及更換背景色
* 防止左滑、右滑操作，可以直接滑到底
* 幫 Button 加上背景色、圓角，使其看起來不會太過單調

## (1/18) Message Board Part 2

[1/18 Teams 課程錄影](https://o365nutc.sharepoint.com/:v:/s/msteams_ed6098/EQGLSJDkbntLuAnSCcpqxnkBp5M0nKN2zTu4NJXRl8-3xg?e=r43t67)

### 會用到的技能

* RealmSwift
* class
* Singleton
* CocoaPods／Swift Package Manager
* MVC Architecture

### 作業

* 實作「更新」操作，並實際將 Database 內的資料進行更新
* 實作「排序」操作，並讓 UI 依照所選的排序方式進行更新
* 將 Database 的操作寫成一個 Singleton，並將相關操作改由這個 Singleton Object 處理

## (2/2) Message Board Part 3

### 會用到的技能

* UIBarButtonItems
* UNNotification

### 作業

* 在 UIBarButtonItems 上實作與 UIButton 相同的功能
* 執行新增、更新、刪除操作時，要跳 Notification 出來

## (2/3) 串接空氣品質指數 (AQI) API

### 會用到的技能

* class
* struct
* Codable
* JSONDecoder
* extension
* Singleton
* URLSession
* UITableView
* UITableView Cell
* UITextField
* UIButton
* UINavigationController
* enum
* switch case
* UILabel
* Auto Layout
* MVC Architecture
* Postman

### 作業

* 設計每個 Cell 點進去後的詳細資訊畫面，需要帶入 AQI 的相關資訊

## (2/6) UserDefaults

### 會用到的技能

* class
* Singleton
* UserDefaults
* enum
* get、set

### 作業

* 將每個 Cell 點進去後的詳細資訊畫面所需的資料來源改從 UserDefaults 取得

## (2/7) Swift 語法講解

### 會用到的技能

* closures
* Results type
