class BGImageModel {
  int? status;
  String? message;
  List<BGImageData>? data;

  BGImageModel({this.status, this.message, this.data});

  BGImageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BGImageData>[];
      json['data'].forEach((v) {
        data!.add(new BGImageData.fromJson(v));
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

class BGImageData {
  int? id;
  String? title;
  String? description;
  String? imageUrl;

  BGImageData({this.id, this.title, this.description, this.imageUrl});

  BGImageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
