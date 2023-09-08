import 'dart:math';

import 'package:anim_rive/core/utils/rive.dart';
import 'package:anim_rive/models/menu.dart';
import 'package:anim_rive/presentation/components/menu_btn.dart';
import 'package:anim_rive/presentation/components/side_bar.dart';
import 'package:anim_rive/presentation/screens/tabs/home/home.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with SingleTickerProviderStateMixin {
  late SMIBool chatTrigger;
  late SMIBool searchTrigger;
  late SMIBool timerTrigger;
  late SMIBool bellTrigger;
  late SMIBool profileTrigger;

  int selectedIndex = 0;
  PageController pageController = PageController();

  void updateSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
      // Update the opacity of each trigger based on the selected index.
      chatTrigger.change(index == 0);
      searchTrigger.change(index == 1);
      timerTrigger.change(index == 2);
      bellTrigger.change(index == 3);
      profileTrigger.change(index == 4);
    });
  }

  bool isSideBarOpen = false;

  Menu selectedBottonNav = bottomNavItems.first;
  Menu selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(193, 7, 7, 60),
      // body: PageView(
      //   controller: pageController,
      //   onPageChanged: (index) {
      //     setState(() {
      //       selectedIndex = index;
      //     });
      //   },
      //   children: const [
      //     HomeScreen(),
      //     SearchScreen(),
      //     TimerScreen(),
      //     NotificationScreen(),
      //     ProfileScreen(),
      //   ],
      // ),
      body: Stack(
        children: [
          AnimatedPositioned(
            width: 288,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 0 : -288,
            top: 0,
            child: const SideBar(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                  1 * animation.value - 30 * (animation.value) * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scalAnimation.value,
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                  child: HomeScreen(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 220 : 0,
            top: 16,
            child: MenuBtn(
              press: () {
                isMenuOpenInput.value = !isMenuOpenInput.value;

                if (_animationController.value == 0) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }

                setState(
                  () {
                    isSideBarOpen = !isSideBarOpen;
                  },
                );
              },
              riveOnInit: (artboard) {
                final controller = StateMachineController.fromArtboard(
                    artboard, "State Machine");

                artboard.addController(controller!);

                isMenuOpenInput =
                    controller.findInput<bool>("isOpen") as SMIBool;
                isMenuOpenInput.value = true;
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          decoration: const BoxDecoration(
              color: Color.fromARGB(193, 7, 7, 60),
              borderRadius: BorderRadius.all(Radius.circular(24))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int index = 0; index < 5; index++)
                GestureDetector(
                  onTap: () {
                    updateSelectedIndex(index);
                  },
                  child: Opacity(
                    opacity: index == selectedIndex ? 1.0 : 0.5,
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: RiveAnimation.asset(
                        RiveUtils.icons,
                        artboard: _getArtboardName(index),
                        onInit: (artboard) {
                          StateMachineController controller =
                              RiveUtils.getRiverController(
                            artboard,
                            stateMachineName: _getStateMachineName(index),
                          );
                          // Assign the corresponding trigger based on the index.
                          switch (index) {
                            case 0:
                              chatTrigger =
                                  controller.findSMI("active") as SMIBool;
                              break;
                            case 1:
                              searchTrigger =
                                  controller.findSMI("active") as SMIBool;
                              break;
                            case 2:
                              timerTrigger =
                                  controller.findSMI("active") as SMIBool;
                              break;
                            case 3:
                              bellTrigger =
                                  controller.findSMI("active") as SMIBool;
                              break;
                            case 4:
                              profileTrigger =
                                  controller.findSMI("active") as SMIBool;
                              break;
                          }
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getArtboardName(int index) {
    switch (index) {
      case 0:
        return "CHAT";
      case 1:
        return "SEARCH";
      case 2:
        return "TIMER";
      case 3:
        return "BELL";
      case 4:
        return "USER";
      default:
        return "";
    }
  }

  String _getStateMachineName(int index) {
    switch (index) {
      case 0:
        return "CHAT_Interactivity";
      case 1:
        return "SEARCH_Interactivity";
      case 2:
        return "TIMER_Interactivity";
      case 3:
        return "BELL_Interactivity";
      case 4:
        return "USER_Interactivity";
      default:
        return "";
    }
  }
}

class RiveAsset {
  final String artboard, stateMAchineName, title, src;
  late SMIBool? input;

  RiveAsset({
    required this.artboard,
    required this.stateMAchineName,
    required this.title,
    required this.src,
  });

  set setInput(SMIBool status) {
    input = status;
  }

  List<RiveAsset> bottomNavs = [
    RiveAsset(
      artboard: "CHAT",
      stateMAchineName: "CHAT_interactivity",
      title: "Chat",
      src: RiveUtils.icons,
    ),
    RiveAsset(
      artboard: "SEARCH",
      stateMAchineName: "SEARCH_interactivity",
      title: "Search",
      src: RiveUtils.icons,
    ),
    RiveAsset(
      artboard: "TIMER",
      stateMAchineName: "TIMER_interactivity",
      title: "Timer",
      src: RiveUtils.icons,
    ),
    RiveAsset(
      artboard: "BELL",
      stateMAchineName: "BELL_interactivity",
      title: "Notification",
      src: RiveUtils.icons,
    ),
    RiveAsset(
      artboard: "USER",
      stateMAchineName: "USER_interactivity",
      title: "Profile",
      src: RiveUtils.icons,
    ),
  ];
}



//   ...List.generate(
//                 bottomNavs.length,
//                 (index) => GestureDetector(
//                   onTap: () {
//                     bottomNavs[index].input!.change(true);
//                     if (bottomNavs[index] != selectedBottomNav) {
//                       setState(() {
//                         selectedBottomNav = bottomNavs[index];
//                       });
//                     }
//                     Future.delayed(
//                       const Duration(seconds: 1),
//                       () {
//                         bottomNavs[index].input!.change(false);
//                       },
//                     );
//                   },
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         margin: const EdgeInsets.only(bottom: 2),
//                         height: 4,
//                         width: bottomNavs[index] == selectedBottomNav ? 20 : 0,
//                         decoration: const BoxDecoration(
//                           color: Color(0xFF81B4FF),
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 36,
//                         height: 36,
//                         child: Opacity(
//                           opacity:
//                               bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
//                           child: RiveAnimation.asset(
//                             bottomNavs[index].src,
//                             artboard: bottomNavs[index].artboard,
//                             onInit: (artboard) {
//                               StateMachineController controller =
//                                   RiveUtils.getRiverController(artboard,
//                                 stateMachineName:
//                                     bottomNavs[index].stateMachineName,
//                               );
//                               bottomNavs[index].input =
//                                   controller.findSMI("active") as SMIBool;
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
