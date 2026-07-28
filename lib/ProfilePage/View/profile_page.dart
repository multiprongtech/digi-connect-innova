import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:digi_connect/ProfilePage/View/profile_controller.dart';
import 'package:digi_connect/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userData = UserData().userData;

//: menu tapped
  void menuTapped() {
    drawerKey.currentState!.openDrawer();
  }

  _deleteUser() async {
    final response = await ProfilePageController().deleteUser();
    if (response.status == 200) {
      setState(() {
        UserData().userData = null;
      });
    }
    AppConstant.showSnackBar("Alert", response.message ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileHeader(menuTapped: menuTapped),
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  width: Get.width * 0.8,
                  height: Get.height * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color.fromARGB(255, 238, 234, 234),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 100,
                      ),
                      Text(
                        userData?.userName ?? 'Anonymous',
                        style: AppTextStyles.heading1(context),
                        textAlign: TextAlign.center,
                      ),
                      AppTextStyles.blankHeight(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Emp Code:',
                            style: AppTextStyles.heading2(context),
                          ),
                          Text(
                            '${userData?.empCode}',
                            style: AppTextStyles.mediumTitle(context),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'HQ:',
                            style: AppTextStyles.heading2(context),
                          ),
                          Text(
                            '${userData?.hq}',
                            style: AppTextStyles.mediumTitle(context),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mobile:',
                            style: AppTextStyles.heading2(context),
                          ),
                          Text(
                            '${userData?.mobileNo}',
                            style: AppTextStyles.mediumTitle(context),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Region:',
                            style: AppTextStyles.heading2(context),
                          ),
                          Text(
                            '${userData?.region}',
                            style: AppTextStyles.mediumTitle(context),
                          ),
                        ],
                      ),
                      UserData().userData == null
                          ? AppTextStyles.blankWidth()
                          : ElevatedButton(
                              style:
                                  AppTheme.lightTheme.elevatedButtonTheme.style,
                              onPressed: () {
                                _deleteUser();
                              },
                              child: Text(
                                'Delete Account',
                                style: AppTextStyles.boldSubTitle(context),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//: Profile Header
class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key, required this.menuTapped});

  Function menuTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      height: 60,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            child: GestureDetector(
              onTap: () {
                menuTapped();
              },
              child: Icon(
                Icons.menu,
                size: 30,
              ),
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colors.white70,
            ),
          ),
          Expanded(
            child: Text(
              'Profile Page',
              style: AppTextStyles.title(context),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
