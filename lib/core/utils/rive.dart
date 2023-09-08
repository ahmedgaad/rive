import 'package:anim_rive/core/utils/constants.dart';
import 'package:rive/rive.dart';

class RiveUtils {
  RiveUtils._();

  static const String shapes = "${Constants.animPath}/shapes.riv";
  static const String button = "${Constants.animPath}/button.riv";
  static const String check = "${Constants.animPath}/check.riv";
  static const String house = "${Constants.animPath}/house.riv";
  static const String icons = "${Constants.animPath}/icons.riv";
  static const String menuBtn = "${Constants.animPath}/menu_button.riv";
  static const String confetti = "${Constants.animPath}/confetti.riv";

  static StateMachineController getRiverController(Artboard artboard,
      {stateMachineName = "State Machine 1"}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    return controller;
  }

    static SMIBool getRiveInput(Artboard artboard,
      {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);

    return controller.findInput<bool>("active") as SMIBool;
  }

  static void chnageSMIBoolState(SMIBool input) {
    input.change(true);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        input.change(false);
      },
    );
  }
}
