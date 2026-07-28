import 'package:digi_connect/AboutPage/View/about_page.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/HelpSupport/View/help_support_page.dart';
import 'package:digi_connect/HomePage/Controller/home_page_controller.dart';
import 'package:digi_connect/HomePage/Model/home_page_model.dart';
import 'package:digi_connect/HomePage/View/category_card.dart';
import 'package:digi_connect/HomePage/View/home_page_header.dart';
import 'package:digi_connect/ImagePage/View/image_pages.dart';
import 'package:digi_connect/PrivacyPolicyPage/privacy_policy_page.dart';
import 'package:digi_connect/ProfilePage/View/profile_page.dart';
import 'package:digi_connect/SideMenuPage/View/side_menu_page.dart';
import 'package:digi_connect/VideosPage/View/video_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Rx<String> menuType = 'home'.obs;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      drawer: SideMenuPage(),
      body: SafeArea(
        child: Obx(() {
          return (menuType.value == 'home')
              ? Home()
              : menuType.value == 'about'
                  ? AboutPage()
                  : menuType.value == 'privacy'
                      ? PrivacyPolicyPage()
                      : menuType.value == 'help'
                          ? HelpAndSupportPage()
                          : ProfilePage();
        }),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final hmController = HomePageController();
  var data = HomePageData().obs;
  var categoriesData = <Categories>[].obs();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getHomeData();
    _basicStatusCheck();
    _checkForPermissions();
  }

  _checkForPermissions() async {
    final status = await Permission.storage.isGranted;
    if (status == false) {
      await Permission.storage.request();
    }

    if (status == PermissionStatus.granted) {
      // File system access is already granted
      print('File system access is granted');
    }
  }

//: basic status check
  _basicStatusCheck() async {
    final verison = NewVersionPlus(
        androidId: 'com.ipca.digi_connect', iOSId: 'com.ipca.digi_connect');
    verison.showAlertIfNecessary(context: context);
  }

//: get home data
  _getHomeData() async {
    final response = await hmController.getAppData();
    if (response.data != null) {
      if (response.data!.categories != null) {
        response.data!.categories = response.data!.categories!
            .where((cat) => cat.id != 1)
            .toList();
        response.data!.categories!
            .sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
      }
    }
    data.value = response.data ?? HomePageData();
  }

//menu tapped
  void menuTapped() {
    drawerKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (data.value.categories == null)
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                HomeHeader(menuTapped: menuTapped),
                Expanded(
                  child: ListView(
                    children: [
                      AppTextStyles.blankHeight(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: Get.width * 0.8,
                          height: Get.width * 0.4,
                          child: PageView(
                            controller: PageController(viewportFraction: 0.95),
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var i = 0;
                                  i < (data.value.banners?.length ?? 0);
                                  i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'Assets/Images/placeholder.png',
                                      image: data.value.banners![i].image ??
                                          'Assets/Images/placeholder.png',
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      AppTextStyles.blankHeight(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Categories',
                          style: AppTextStyles.title(context),
                        ),
                      ),
                      AppTextStyles.blankHeight(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          physics:
                              NeverScrollableScrollPhysics(), // disable GridView's scrolling
                          shrinkWrap: true,
                          itemCount: data.value.categories?.length ?? 0,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              if (data.value.categories![index].id == 1) {
                                Get.to(
                                  VideoPages(
                                    category: data.value.categories![index],
                                  ),
                                );
                              } else {
                                Get.to(
                                  ImagePages(
                                    category: data.value.categories![index],
                                  ),
                                );
                              }
                            },
                            child: CategoryCard(
                              category: data.value.categories?[index],
                            ),
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.55,
                          ),
                        ),
                      ),
                      AppTextStyles.blankHeight(height: 12),
                    ],
                  ),
                ),
              ],
            );
    });
  }
}
