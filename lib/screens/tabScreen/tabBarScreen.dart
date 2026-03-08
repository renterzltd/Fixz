// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/moreScreen/moreScreen.dart';
import 'package:fixz/screens/taskListScreen/taskListScreen.dart';

class HomeTabbarScreen extends StatefulWidget {
  const HomeTabbarScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabbarScreen> createState() => _HomeTabbarScreenState();
}

class _HomeTabbarScreenState extends State<HomeTabbarScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final List<Widget> _children = [
    TaskScreen(),
    MoreScreen(),
    // OrderHistroy(),
    // DashboardScreen(),
    // ProfileScreen()
  ];

  _onTapped(int index) {
    setState(() {
      debugPrint("index $index");
      currentIndexHomeViewer = index;
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndexHomeViewer = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        key: _scaffoldKey,
        body: _children[currentIndexHomeViewer],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType
              .fixed, //if you remove this tab bar will white.
          currentIndex: currentIndexHomeViewer,
          onTap: _onTapped,
          selectedItemColor: AppColors.colorPrimaryDark.lightColorHex(),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.task_outlined, size: 25),
                activeIcon: Icon(Icons.task_outlined,
                    color: AppColors.colorPrimaryDark.lightColorHex(),
                    size: 25),
                label: "Tasks".tr),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz, size: 25),
                activeIcon: Icon(Icons.more_horiz,
                    color: AppColors.colorPrimaryDark.lightColorHex(),
                    size: 25),
                label: 'More'.tr),
          ],
        ),
      ),
    );
  }
}
