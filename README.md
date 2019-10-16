### New Project

#### 說明
        此專案是將自己常用的套件和程式放到這個專案中，之後如果需要新開專案的話，可以直接複製此專案然後在進行 Rename 
[Rename 教學](https://appmakers.dev/how-to-rename-xcode-project/)

注意：
1. 修改 Scheme Name 時，點擊 Scheme 然後點擊 Enter 鍵才能修改。
1. 需要重新 pod install
1. 需在 Build Settings 替換掉所有的 NewProject
1. 出現 The folder “Assets.xcassets” doesn’t exist.，是因為沒有改 project 中目錄的名稱。
    ![修改選中目錄名稱](./修改選中目錄名稱.png)
        
#### New Project 做了什麼呢？
1. Add git, gitignore
1. pod init
1.  * pod 'R.swift'
    * pod 'SwiftLint'
    * pod 'DeviceGuru'
    * pod 'ReachabilitySwift'
1. Add swiftlint.yml
1. Add Build Phases **Before Compile Sources**
    
    * "$PODS_ROOT/R.swift/rswift" generate "$SRCROOT/R.generated.swift"

        **NOTE**

        Add **$TEMP_DIR/rswift-lastrun** to the "Input Files" and **$SRCROOT/R.generated.swift** to the "Output Files" of the Build Phase
        
    * "${PODS_ROOT}/SwiftLint/swiftlint"   
1. Add Log files
1. Add Network files
1. Core Data files
1. Utils files
1. TestTarget
    * TestsTarget -> Build Settings -> Other Swift Flag 要加 “-DTEST”
1. 使用 Storyboarded 要記得在 .storyboard 設定 Storyboard ID
1. swiftformat
    * cd iOS Project 下，到用 “swiftformat --inferoptions . --output .swiftformat” 產生一個 .swiftformat 配置檔案（個人喜歡把 indent set 2），再下 “swiftformat .” 指令調整格式。
1. Cooedinator

##### TODO
1. Firebase Crashly
1. fastlane (optional)

