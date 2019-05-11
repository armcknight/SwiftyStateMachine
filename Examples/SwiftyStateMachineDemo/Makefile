diagrams:
	xcodebuild -workspace SwiftyStateMachineDemo.xcworkspace -scheme SwiftyStateMachineDemoDiagramGenerator -configuration Debug -destination 'platform=iOS Simulator,name=iPhone SE,OS=12.2' -derivedDataPath build test
	find build -name "*.dot" -exec sh -c 'dot -Tpng "{}" > "{}.png"' \;
	find build -name "*.dot.png" -exec sh -c 'mv "{}" .' \;
