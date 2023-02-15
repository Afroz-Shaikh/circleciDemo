import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.red,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue, backgroundColor: Colors.white)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final canContinue = currentStep < 4;
    final canCancel = currentStep > 0;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        // backgroundColor: Colors.black,
        middle: Text('CI/CD Demo'),
      ),
      child: Center(
          child: CupertinoStepper(
              onStepTapped: (step) => setState(() => currentStep = step),
              onStepCancel:
                  canCancel ? () => setState(() => --currentStep) : null,
              onStepContinue:
                  canContinue ? () => setState(() => ++currentStep) : null,
              type: StepperType.vertical,
              currentStep: currentStep,
              steps: [
            for (var i = 0; i < 4; i++)
              _buildStep(
                index: i,
                title: Text('Step ${i + 1}'),
                isActive: i == currentStep,
                state: i == currentStep
                    ? StepState.editing
                    : i < currentStep
                        ? StepState.complete
                        : StepState.indexed,
              ),
            _buildStepError(
              title: const Text('Error'),
              state: StepState.error,
            ),
            _buildStepDisabled(
              title: const Text('Disabled'),
              state: StepState.disabled,
            )
          ])),
    );
  }
}

List subtitles = [
  "Linking with CircleCi",
  "Docker Image",
  "Apk build",
  "Success"
];

Step _buildStep({
  required index,
  required Widget title,
  StepState state = StepState.indexed,
  bool isActive = false,
}) {
  return Step(
    title: title,
    subtitle: Text(subtitles[index]),
    state: state,
    isActive: isActive,
    content: LimitedBox(
      maxWidth: 300,
      maxHeight: 300,
      child: ClipOval(
        child: Container(
          color: Colors.blue,
          child: Icon(Icons.done, color: Colors.white, size: 100),
        ),
      ),
    ),
  );
}

Step _buildStepError({
  required Widget title,
  StepState state = StepState.indexed,
  bool isActive = false,
}) {
  return Step(
    label: const Text("CICD"),
    title: title,
    subtitle: const Text("Linking & Passing Build into Fastlane"),
    state: state,
    isActive: isActive,
    content: LimitedBox(
      maxWidth: 300,
      maxHeight: 300,
      child: Container(
        color: Colors.white,
        child: const Icon(Icons.warning, color: Colors.red, size: 100),
      ),
    ),
  );
}

Step _buildStepDisabled({
  required Widget title,
  StepState state = StepState.indexed,
  bool isActive = false,
}) {
  return Step(
    title: title,
    subtitle: const Text("Last Steps"),
    state: state,
    isActive: isActive,
    content: LimitedBox(
      maxWidth: 300,
      maxHeight: 300,
      child: ClipOval(
        child: Container(
          color: Colors.blue,
          child: const Icon(Icons.warning, color: Colors.red, size: 100),
        ),
      ),
    ),
  );
}
