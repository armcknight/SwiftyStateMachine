test: test-ios test-mac

test-ios:
	xcrun xcodebuild \
		-project SwiftyStateMachine.xcodeproj \
		-scheme SwiftyStateMachine-iOS \
		-sdk iphonesimulator \
		-destination 'platform=iOS simulator,OS=12.2,name=iPhone X' \
		test \
		2>ios-test-errors.log \
		| tee ios-test.log \
		| rbenv exec bundle exec xcpretty -t 

test-mac:
	xcrun xcodebuild \
		-project SwiftyStateMachine.xcodeproj \
		-scheme SwiftyStateMachine-Mac \
		-sdk macosx \
		test \
		2>macos-test-errors.log \
		| tee macos-test.log \
		| rbenv exec bundle exec xcpretty -t