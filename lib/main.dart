import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final canContinue = currentStep < 2;
    final canCancel = currentStep > 0;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Colors.blue,
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
            for (var i = 0; i < 2; i++)
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
      child: Container(
        color: Colors.blueGrey,
        child: Icon(Icons.headphones),
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
    label: Text("CICD"),
    title: title,
    subtitle: Text("Building Apk and ipa File"),
    state: state,
    isActive: isActive,
    content: LimitedBox(
      maxWidth: 300,
      maxHeight: 300,
      child: Container(color: Colors.blueGrey),
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
    subtitle: Text("Last Steps"),
    state: state,
    isActive: isActive,
    content: LimitedBox(
      maxWidth: 300,
      maxHeight: 300,
      child: Container(color: Colors.blueGrey),
    ),
  );
}
