import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextFields.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:digi_connect/FormPage/controller/form_page_controller.dart';
import 'package:digi_connect/FormPage/view/form_page_header.dart';
import 'package:digi_connect/ImagePage/View/image_template_invitation_settig_page.dart';
import 'package:digi_connect/ImagePage/View/image_template_settig_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormPage extends StatelessWidget {
  FormPage({
    super.key,
    required this.templateUrl,
    required this.tempid,
    required this.cat_id,
    required this.heading,
  });

  String templateUrl;
  String tempid;
  int cat_id;
  String heading;
  final controller = FormPageController();

  final text1_Ctrl = TextEditingController();
  final text2_Ctrl = TextEditingController();
  final text3_Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("cat_id==>$cat_id");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FormPageHeader(header: heading),
            Expanded(
              child: (cat_id == 3)
                  ? Category3Form(
                      controller: controller,
                      templateUrl: templateUrl,
                      cat_id: cat_id,
                      tempid: tempid,
                    )
                  : (cat_id == 2 || cat_id == 4)
                      ? Category2Form(
                          controller: controller,
                          templateUrl: templateUrl,
                          cat_id: cat_id,
                          tempid: tempid,
                        )
                      : (cat_id == 6)
                          ? Category6Form(
                              controller: controller,
                              templateUrl: templateUrl,
                              cat_id: cat_id,
                              tempid: tempid,
                            )
                     : (cat_id == 28)
                        ? CategoryNewForm(
                            controller: controller,
                            templateUrl: templateUrl,
                            cat_id: cat_id,
                            tempid: tempid,
                         )
                          : Category1Form(
                              controller: controller,
                              templateUrl: templateUrl,
                              cat_id: cat_id,
                              tempid: tempid,
                            ),
            ),
          ],
        ),
      ),
    );
  }
}

//form 2 Birthday
class Category2Form extends StatelessWidget {
  Category2Form({
    super.key,
    required this.controller,
    required this.templateUrl,
    required this.tempid,
    required this.cat_id,
  });

  String templateUrl;
  String tempid;
  int cat_id;
  FormPageController controller;
  final text1_Ctrl = TextEditingController();
  final text2_Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      children: (cat_id == 2)
          ? [
              Text(
                'Enter Dr Name',
                style: AppTextStyles.subTitle(context),
              ),
              TextField(
                decoration: AppTextFields.roundedBorder(
                  backgroundColor: AppConstant.textFieldBgColor,
                  borderColor: Colors.transparent,
                ),
                controller: text1_Ctrl,
              ),
              AppTextStyles.blankHeight(
                height: 16,
              ),
              Text(
                'Enter Specialty',
                style: AppTextStyles.subTitle(context),
              ),
              TextField(
                decoration: AppTextFields.roundedBorder(
                  backgroundColor: AppConstant.textFieldBgColor,
                  borderColor: Colors.transparent,
                ),
                controller: text2_Ctrl,
              ),
              AppTextStyles.blankHeight(
                height: 16,
              ),
              SizedBox(
                width: Get.width * 0.85,
                height: 45,
                child: ElevatedButton(
                  style: AppTheme.lightTheme.elevatedButtonTheme.style,
                  onPressed: () {
                    if (text1_Ctrl.text.isEmpty) {
                      AppConstant.showSnackBar(
                          "Alert", "Dr name should not be empty.");
                    } else if (text2_Ctrl.text.isEmpty) {
                      AppConstant.showSnackBar(
                          "Alert", "Specialty should not be blank.");
                    } else {
                      Get.to(
                        ImageTemplateSettingPage(
                          templateUrl: templateUrl,
                          cat_id: cat_id,
                          imagePath1: '',
                          inputTextTo: text1_Ctrl.text,
                          inputTextDesignation: text2_Ctrl.text,
                          inputTextFrom: '',
                          inputTextLocation: '',
                          tempid: tempid,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Submit',
                    style: AppTextStyles.subTitle(context),
                  ),
                ),
              ),
            ]
          : [
              Text(
                'Enter couple name',
                style: AppTextStyles.subTitle(context),
              ),
              TextField(
                decoration: AppTextFields.roundedBorder(
                  backgroundColor: AppConstant.textFieldBgColor,
                  borderColor: Colors.transparent,
                ),
                controller: text1_Ctrl,
              ),
              AppTextStyles.blankHeight(
                height: 16,
              ),
              SizedBox(
                width: Get.width * 0.85,
                height: 45,
                child: ElevatedButton(
                  style: AppTheme.lightTheme.elevatedButtonTheme.style,
                  onPressed: () {
                    if (text1_Ctrl.text.isEmpty) {
                      AppConstant.showSnackBar(
                          "Alert", "Dr name should not be empty.");
                    } else {
                      Get.to(
                        ImageTemplateSettingPage(
                          templateUrl: templateUrl,
                          cat_id: cat_id,
                          imagePath1: '',
                          inputTextTo: text1_Ctrl.text,
                          inputTextDesignation: '',
                          inputTextFrom: '',
                          inputTextLocation: '',
                          tempid: tempid,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Submit',
                    style: AppTextStyles.subTitle(context),
                  ),
                ),
              ),
            ],
    );
  }
}

//form 27 Birthday
class Category27Form extends StatelessWidget {
  Category27Form({
    super.key,
    required this.controller,
    required this.templateUrl,
    required this.tempid,
    required this.cat_id,
  });

  String templateUrl;
  String tempid;
  int cat_id;
  FormPageController controller;
  final text1_Ctrl = TextEditingController();
  final text2_Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      children: [
        Text(
          'Enter Dr Name',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: text1_Ctrl,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Enter Specialty',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: text2_Ctrl,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Upload Image',
          style: AppTextStyles.subTitle(context),
        ),
        Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppConstant.textFieldBgColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    (controller.image1.value == null)
                        ? 'No image selected'
                        : controller.image1.value!.path,
                    style: AppTextStyles.subTitle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: AppTheme.grayThemeStyle(),
                    onPressed: () {
                      controller.showBottomSheetWithOption(context, 1);
                    },
                    child: Text(
                      'Browse',
                      style: AppTextStyles.subTitle(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        SizedBox(
          width: Get.width * 0.85,
          height: 45,
          child: ElevatedButton(
            style: AppTheme.lightTheme.elevatedButtonTheme.style,
            onPressed: () {
              if (text1_Ctrl.text.isEmpty) {
                AppConstant.showSnackBar(
                    "Alert", "Dr name should not be empty.");
              } else if (text2_Ctrl.text.isEmpty) {
                AppConstant.showSnackBar(
                    "Alert", "Specialty field should not be empty.");
              } else if (controller.image1.value == null) {
                AppConstant.showSnackBar("Alert", "Image should not be empty.");
              } else {
                Get.to(
                  ImageTemplateSettingPage(
                    templateUrl: templateUrl,
                    cat_id: cat_id,
                    imagePath1: (controller.image1.value!.path),
                    inputTextTo: text1_Ctrl.text,
                    inputTextDesignation: text2_Ctrl.text,
                    inputTextFrom: '',
                    inputTextLocation: '',
                    tempid: tempid,
                  ),
                );
              }
            },
            child: Text(
              'Submit',
              style: AppTextStyles.subTitle(context),
            ),
          ),
        ),
      ],
    );
  }
}

//form 27 Birthday
class Category1Form extends StatelessWidget {
  Category1Form({
    super.key,
    required this.controller,
    required this.templateUrl,
    required this.tempid,
    required this.cat_id,
  });

  String templateUrl;
  String tempid;
  int cat_id;
  FormPageController controller;
  final text1_Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      children: [
        Text(
          'Enter Dr Name',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: text1_Ctrl,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Upload Image',
          style: AppTextStyles.subTitle(context),
        ),
        Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppConstant.textFieldBgColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    (controller.image1.value == null)
                        ? 'No image selected'
                        : controller.image1.value!.path,
                    style: AppTextStyles.subTitle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: AppTheme.grayThemeStyle(),
                    onPressed: () {
                      controller.showBottomSheetWithOption(context, 1);
                    },
                    child: Text(
                      'Browse',
                      style: AppTextStyles.subTitle(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        SizedBox(
          width: Get.width * 0.85,
          height: 45,
          child: ElevatedButton(
            style: AppTheme.lightTheme.elevatedButtonTheme.style,
            onPressed: () {
              if (text1_Ctrl.text.isEmpty) {
                AppConstant.showSnackBar(
                    "Alert", "Dr name should not be empty.");
              } else if (controller.image1.value == null) {
                AppConstant.showSnackBar("Alert", "Image should not be empty.");
              } else {
                Get.to(
                  ImageTemplateSettingPage(
                    templateUrl: templateUrl,
                    cat_id: cat_id,
                    imagePath1: (controller.image1.value!.path),
                    inputTextTo: text1_Ctrl.text,
                    inputTextDesignation: '',
                    inputTextFrom: '',
                    inputTextLocation: '',
                    tempid: tempid,
                  ),
                );
              }
            },
            child: Text(
              'Submit',
              style: AppTextStyles.subTitle(context),
            ),
          ),
        ),
      ],
    );
  }
}

//Category 3
class Category3Form extends StatelessWidget {
  Category3Form({
    super.key,
    required this.controller,
    required this.templateUrl,
    required this.tempid,
    required this.cat_id,
  });

  FormPageController controller;
  final toTxtCtrl = TextEditingController();
  final fromTxtCtrl = TextEditingController();
  final position = TextEditingController();
  final location = TextEditingController();

  String templateUrl;
  String tempid;
  int cat_id;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      children: [
        Text(
          'Enter Dr Name (Without Dr)',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: toTxtCtrl,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Enter Your Name',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: fromTxtCtrl,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Your Designation',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: position,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Your Headquarter',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: location,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Add Your Pic',
          style: AppTextStyles.subTitle(context),
        ),
        Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppConstant.textFieldBgColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    (controller.image1.value == null)
                        ? 'No image selected'
                        : controller.image1.value!.path,
                    style: AppTextStyles.subTitle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: AppTheme.grayThemeStyle(),
                    onPressed: () {
                      controller.showBottomSheetWithOption(context, 1);
                    },
                    child: Text(
                      'Browse',
                      style: AppTextStyles.subTitle(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        SizedBox(
          width: Get.width * 0.85,
          height: 45,
          child: ElevatedButton(
            style: AppTheme.lightTheme.elevatedButtonTheme.style,
            onPressed: () {
              if (toTxtCtrl.text.isEmpty) {
                AppConstant.showSnackBar(
                    "Alert", "Input text to should not be empty.");
              } else if (fromTxtCtrl.text.isEmpty) {
                AppConstant.showSnackBar(
                    "Alert", "Input text from should not be empty.");
              } else {
                Get.to(
                  ImageTemplateSettingPage(
                    templateUrl: templateUrl,
                    cat_id: cat_id,
                    imagePath1: controller.image1.value?.path ?? '',
                    inputTextTo: toTxtCtrl.text,
                    inputTextDesignation: position.text,
                    inputTextFrom: fromTxtCtrl.text,
                    inputTextLocation: location.text,
                    tempid: tempid,
                  ),
                );
              }
            },
            child: Text(
              'Submit',
              style: AppTextStyles.subTitle(context),
            ),
          ),
        ),
      ],
    );
  }
}

//Category 3
class Category6Form extends StatelessWidget {
  Category6Form({
    super.key,
    required this.controller,
    required this.templateUrl,
    required this.tempid,
    required this.cat_id,
  });

  FormPageController controller;
  final toTxtCtrl = TextEditingController();
  final fromTxtCtrl = TextEditingController();
  final position = TextEditingController();
  final location = TextEditingController();

  String templateUrl;
  String tempid;
  int cat_id;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      children: [
        Text(
          'Add Your Pic',
          style: AppTextStyles.subTitle(context),
        ),
        Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppConstant.textFieldBgColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    (controller.image1.value == null)
                        ? 'No image selected'
                        : controller.image1.value!.path,
                    style: AppTextStyles.subTitle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: AppTheme.grayThemeStyle(),
                    onPressed: () {
                      controller.showBottomSheetWithOption(context, 1);
                    },
                    child: Text(
                      'Browse',
                      style: AppTextStyles.subTitle(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        SizedBox(
          width: Get.width * 0.85,
          height: 45,
          child: ElevatedButton(
            style: AppTheme.lightTheme.elevatedButtonTheme.style,
            onPressed: () {
              if (controller.image1.value == null) {
                AppConstant.showSnackBar("Alert", "Image should not be empty.");
              } else {
                Get.to(
                  ImageTemplateSettingPage(
                    templateUrl: templateUrl,
                    cat_id: cat_id,
                    imagePath1: (controller.image1.value!.path),
                    inputTextTo: '',
                    inputTextDesignation: '',
                    inputTextFrom: '',
                    inputTextLocation: '',
                    tempid: tempid,
                  ),
                );
              }
            },
            child: Text(
              'Submit',
              style: AppTextStyles.subTitle(context),
            ),
          ),
        ),
      ],
    );
  }
}

//form New
class CategoryNewForm extends StatelessWidget {
  CategoryNewForm({
    super.key,
    required this.controller,
    required this.templateUrl,
    required this.tempid,
    required this.cat_id,
  });

  String templateUrl;
  String tempid;
  int cat_id;
  FormPageController controller;
  final text1_Ctrl = TextEditingController();
  final text2_Ctrl = TextEditingController();
  final text3_Ctrl = TextEditingController();
  final text4_Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      children: [
        Text(
          'Enter Topic',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: text1_Ctrl,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Enter Speaker Name',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: text2_Ctrl,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Enter Date',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: text3_Ctrl,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        Text(
          'Enter Venue',
          style: AppTextStyles.subTitle(context),
        ),
        TextField(
          decoration: AppTextFields.roundedBorder(
            backgroundColor: AppConstant.textFieldBgColor,
            borderColor: Colors.transparent,
          ),
          controller: text4_Ctrl,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        AppTextStyles.blankHeight(
          height: 16,
        ),
        SizedBox(
          width: Get.width * 0.85,
          height: 45,
          child: ElevatedButton(
            style: AppTheme.lightTheme.elevatedButtonTheme.style,
            onPressed: () {
              if (text1_Ctrl.text.isEmpty) {
                AppConstant.showSnackBar(
                    "Alert", "Topic should not be empty.");
              }
              else if (text2_Ctrl.text.isEmpty) {
                AppConstant.showSnackBar(
                    "Alert", "Speaker name should not be empty.");
              }
              else if (text3_Ctrl.text.isEmpty) {
                AppConstant.showSnackBar(
                    "Alert", "Date should not be empty.");
              }
              else if (text4_Ctrl.text.isEmpty) {
                AppConstant.showSnackBar(
                    "Alert", "Venue should not be empty.");
              }
              else {
                Get.to(
                  ImageTemplateInvitationSettigPage(
                    templateUrl: templateUrl,
                    cat_id: 28,
                    imagePath1: '',
                    inputTextTo: text1_Ctrl.text,
                    inputTextDesignation: text2_Ctrl.text,
                    inputTextFrom: text3_Ctrl.text,
                    inputTextLocation: text4_Ctrl.text,
                    tempid: tempid,
                  ),
                );
              }
            },
            child: Text(
              'Submit',
              style: AppTextStyles.subTitle(context),
            ),
          ),
        ),
      ],
    );
  }
}
