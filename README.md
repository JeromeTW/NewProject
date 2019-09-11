### New Project

#### 說明
        此專案是將自己常用的套件和程式放到這個專案中，之後如果需要新開專案的話，可以直接複製此專案然後在進行 Rename 
[Rename 教學](https://appmakers.dev/how-to-rename-xcode-project/)

注意：
1. 修改 Scheme Name 時，點擊 Scheme 然後點擊 Enter 鍵才能修改。
1. 需要重新 pod install
1. 需在 Build Settings 替換掉所有的 NewProject
        
#### New Project 做了什麼呢？
1. Add git, gitignore
1. pod init
1.  * pod 'R.swift'
    * pod 'SwiftLint'
1. Add swiftlint.yml
1. Add Build Phases **Before Compile Sources**
    
    * "$PODS_ROOT/R.swift/rswift" generate "$SRCROOT/R.generated.swift"

        **NOTE**

        Add **$TEMP_DIR/rswift-lastrun** to the "Input Files" and **$SRCROOT/R.generated.swift** to the "Output Files" of the Build Phase
        
    * "${PODS_ROOT}/SwiftLint/swiftlint"   
1. Add Log files
1. Add Network files

##### TODO
1. Firebase Crashly
1. swiftformat
1. TestTarget
1. fastlane (optional)

新開專案 Copy NewProject 專案，再 Rename
https://appmakers.dev/how-to-rename-xcode-project/
