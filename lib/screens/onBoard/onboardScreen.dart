// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:fixz/hdHelper/appImages.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:intro_slider/intro_slider.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  List<ContentConfig> slides = [];
  List<Widget> tabs = [];

  List introContent = [
    {
      "title": "Easy Search",
      "image": APPIMAGES.easySearch,
      "desc":
          "You can easily choose your service provider based on their rating, location, and cost."
    },
    {
      "title": "Transparent pricing",
      "image": APPIMAGES.transparentPriice,
      "desc":
          "Prices are provided directly by the service providers, so you can easily compare quotations with just a few clicks. Fixz is here to save you both time and money."
    },
    {
      "title": "Dual Protection",
      "image": APPIMAGES.dualProtection,
      "desc":
          "Our service providers are honest, punctual, and highly professional, so you can trust that you will receive a safe and high-quality service."
    },
    {
      "title": "Customer rating",
      "image": APPIMAGES.customerRating,
      "desc":
          "You can choose your service providers based on previous customer ratings and reviews, and you can also leave your own review."
    },
  ];

  _changeStatus() async {
    //Show onboarding only for first time.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("isFirstTime", 'yes');
  }

  _setWidgetStatus() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final status = prefs.getString('isHomeViewerLogin') ?? '';
    // if (status == 'yes') {
    //   return NavigationService()
    //       .setNavigator(HomeTabbarScreen(), isRemoveAll: true);
    // } else {
    //   return NavigationService()
    //       .setNavigator(HomeViewerDashboard(), isRemoveAll: true);
    // }
    NavigationService().setNavigator(HomeViewerDashboard(), isRemoveAll: true);
  }

  @override
  void initState() {
    for (int i = 0; i < introContent.length; i++) {
      ContentConfig slide = ContentConfig(
        title: introContent[i]['title'],
        description: introContent[i]['desc'],
        marginTitle: const EdgeInsets.only(
          top: 100.0,
          bottom: 50.0,
        ),
        maxLineTextDescription: 2,
        styleTitle: TextStyle(
            color: AppColors.black.lightColorHex(),
            fontSize: 30,
            fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        marginDescription: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20),
        styleDescription: TextStyle(
            color: AppColors.gray.lightColorHex(),
            fontSize: 14,
            fontWeight: FontWeight.w700),
        foregroundImageFit: BoxFit.fitWidth,
        pathImage: introContent[i]['image'],
      );
      slides.add(slide);
    }

    _changeStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // colorActiveDot: AppColors.colorPrimary.lightColorHex(),
      listContentConfig: slides,
      backgroundColorAllTabs: Colors.white,
      listCustomTabs: renderListCustomTabs(),
      renderNextBtn: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: AppColors.colorPrimaryDark.lightColorHex(),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 18,
        ),
      ),
      renderDoneBtn: Container(
        height: 30,
        width: 80,
        decoration: BoxDecoration(
          color: AppColors.colorPrimaryDark.lightColorHex(),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          'DONE',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      renderSkipBtn: Text(
        'Skip',
        style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      ),
      onDonePress: () async {
        // NavigationService().setNavigator(SplashScreen());
        _setWidgetStatus();
      },
      onSkipPress: () async {
        // NavigationService().setNavigator(SplashScreen());
        _setWidgetStatus();
      },
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      ContentConfig currentSlide = slides[i];
      tabs.add(SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              setHeight(45),
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage!,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  currentSlide.title!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: const EdgeInsets.only(top: 20.0),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  currentSlide.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: const EdgeInsets.only(top: 20.0, bottom: 100.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }
}
