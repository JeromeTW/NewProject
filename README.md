### 新開專案
1. git, gitignore from TaiChuangWeather project
1. pod init
1.  * pod 'R.swift'
    * pod 'SwiftLint'
1. swiftlint.yml from TaiChuangWeather project
1. Build Phases **Before Compile Sources**
    
    * "$PODS_ROOT/R.swift/rswift" generate "$SRCROOT/R.generated.swift"

        **NOTE**

        Add **$TEMP_DIR/rswift-lastrun** to the "Input Files" and **$SRCROOT/R.generated.swift** to the "Output Files" of the Build Phase
        
    * "${PODS_ROOT}/SwiftLint/swiftlint"   
1. Log folder from TaiChuangWeather project
1. Network from TaiChuangWeather project
1. Firebase Crashly
1. swiftformat
1. TestTarget
