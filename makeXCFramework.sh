#!/bin/sh

FRAMEWORK_NAME="FBSnapshotTestCase"
IOS_SCHMEM="FBSnapshotTestCase-iOS"
TV_SCHEME="FBSnapshotTestCase-tvOS"

IOS_ARCHIVE_PATH="./build/archives/ios.xcarchive"
IOS_SIMULATOR_ARCHIVE_PATH="./build/archives/ios_sim.xcarchive"

xcodebuild archive -scheme "FBSnapshotTestCase iOS" -archivePath ${IOS_ARCHIVE_PATH} -sdk iphoneos SKIP_INSTALL=NO
xcodebuild archive -scheme "FBSnapshotTestCase iOS" -archivePath ${IOS_SIMULATOR_ARCHIVE_PATH} -sdk iphonesimulator SKIP_INSTALL=NO

xcodebuild -create-xcframework \
  -framework ${IOS_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${IOS_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -output "./build/${FRAMEWORK_NAME}.xcframework"