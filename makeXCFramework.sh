#!/bin/sh

FRAMEWORK_NAME="FBSnapshotTestCase"

IOS_ARCHIVE_PATH="./build/archives/ios.xcarchive"
IOS_SIMULATOR_ARCHIVE_PATH="./build/archives/ios_sim.xcarchive"

xcodebuild archive -scheme "FBSnapshotTestCase iOS" -archivePath ${IOS_ARCHIVE_PATH} -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
xcodebuild archive -scheme "FBSnapshotTestCase iOS" -archivePath ${IOS_SIMULATOR_ARCHIVE_PATH} -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
  -framework ${IOS_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${IOS_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -output "./build/${FRAMEWORK_NAME}.xcframework"

find ./build/ -name "*.swiftinterface" -exec sed -i -e 's/FBSnapshotTestCase\.//g' {} \;
find ./build/ -name "*.swiftinterface-e" -exec rm {} \;