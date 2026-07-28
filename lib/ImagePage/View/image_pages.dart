import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/FormPage/view/form_page.dart';
import 'package:digi_connect/HomePage/Model/home_page_model.dart';
import 'package:digi_connect/ImagePage/Controller/ImagePageController.dart';
import 'package:digi_connect/ImagePage/Model/ImageTemplateModel.dart';
import 'package:digi_connect/ImagePage/View/image_page_header.dart';
import 'package:digi_connect/LoginPage/View/login_page.dart';
import 'package:digi_connect/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePages extends StatefulWidget {
  ImagePages({super.key, required this.category});
  Categories category;

  @override
  State<ImagePages> createState() => _ImagePagesState();
}

class _ImagePagesState extends State<ImagePages> {
  final controller = ImagePageController();
  var templates = <ImageTemplateData>[].obs;
  var apiMessage = "Fetching data...".obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTemplates();
  }

  _getTemplates() async {
    final response = await controller.getTemplateData(widget.category.id ?? 0);
    templates.value = response.data ?? [];
    if (templates.value.length < 1) {
      apiMessage.value = response.message ?? "No data found.";
    } else {
      apiMessage.value = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ImagePageHeader(
              category: widget.category,
            ),
            AppTextStyles.blankHeight(height: 12),
            Obx(() {
              return !apiMessage.value.isEmpty
                  ? Center(
                      child: Text(
                        apiMessage.value,
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: templates.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              if (UserData().userData == null) {
                                Get.to(LoginPage());
                                /*Get.to(
                                  FormPage(
                                    templateUrl:
                                    templates.value[index].imageUrl ?? '',
                                    cat_id: widget.category.id ?? 0,
                                    heading: widget.category.title ??
                                        'Seasional Image',
                                    tempid: '${templates.value[index].id}',
                                  ),
                                );*/
                              } else {
                                Get.to(
                                  FormPage(
                                    templateUrl:
                                        templates.value[index].imageUrl ?? '',
                                    cat_id: widget.category.id ?? 0,
                                    heading: widget.category.title ??
                                        'Seasional Image',
                                    tempid: '${templates.value[index].id}',
                                  ),
                                );
                              }
                            },
                            child: ImageCard(
                              imageModel: templates.value[index],
                            ),
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 0,
                            childAspectRatio: 1 / 1.7,
                          ),
                        ),
                      ),
                    );
            }),
            AppTextStyles.blankHeight(),
          ],
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  ImageCard({super.key, required this.imageModel});

  ImageTemplateData imageModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        image: DecorationImage(
          image: NetworkImage(imageModel.imageUrl ?? ''),
          fit: BoxFit.contain,
        ),
      ),
      child: FadeInImage.assetNetwork(
        placeholder: 'Assets/Images/placeholder.png',
        image: imageModel.imageUrl ?? 'Assets/Images/placeholder.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
