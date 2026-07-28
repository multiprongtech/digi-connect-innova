class ImageTemplateModel {
  int? status;
  String? message;
  List<ImageTemplateData>? data;

  ImageTemplateModel({this.status, this.message, this.data});

  ImageTemplateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ImageTemplateData>[];
      json['data'].forEach((v) {
        data!.add(new ImageTemplateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageTemplateData {
  int? id;
  String? title;
  String? description;
  String? imageUrl;
  String? categoryName;
  int? category;
  int? language;

  ImageTemplateData(
      {this.id,
      this.title,
      this.description,
      this.imageUrl,
      this.categoryName,
      this.category,
      this.language});

  ImageTemplateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['image_url'];
    categoryName = json['category_name'];
    category = json['category'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['category_name'] = this.categoryName;
    data['category'] = this.category;
    data['language'] = this.language;
    return data;
  }
}
