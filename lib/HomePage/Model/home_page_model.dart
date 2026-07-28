class HomePageModel {
  int? status;
  String? message;
  HomePageData? data;

  HomePageModel({this.status, this.message, this.data});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new HomePageData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomePageData {
  int? id;
  String? baseUrl;
  String? primaryColor;
  String? appLogo;
  String? splashScreen;
  List<Banners>? banners;
  List<Logos>? logos;
  List<Categories>? categories;

  HomePageData(
      {this.id,
      this.baseUrl,
      this.primaryColor,
      this.appLogo,
      this.splashScreen,
      this.banners,
      this.logos,
      this.categories});

  HomePageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baseUrl = json['base_url'];
    primaryColor = json['primary_color'];
    appLogo = json['app_logo'];
    splashScreen = json['splash_screen'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['logos'] != null) {
      logos = <Logos>[];
      json['logos'].forEach((v) {
        logos!.add(new Logos.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['base_url'] = this.baseUrl;
    data['primary_color'] = this.primaryColor;
    data['app_logo'] = this.appLogo;
    data['splash_screen'] = this.splashScreen;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.logos != null) {
      data['logos'] = this.logos!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? title;
  String? image;

  Banners({this.title, this.image});

  Banners.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}

class Logos {
  String? title;
  String? image;
  int? sortOrder;

  Logos({this.title, this.image, this.sortOrder});

  Logos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['sort_order'] = this.sortOrder;
    return data;
  }
}

class Categories {
  int? id;
  String? title;
  String? image;
  String? colour;
  int? sortOrder;

  Categories({this.id, this.title, this.image, this.colour, this.sortOrder});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    colour = json['colour'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['colour'] = this.colour;
    data['sort_order'] = this.sortOrder;
    return data;
  }
}


/*
class Categories {
  int? id;
  String? title;
  String? image;
  String? colour;
  Categories({this.id, this.title, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    colour = json['colour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['colour'] = this.colour;
    return data;
  }
}
*/