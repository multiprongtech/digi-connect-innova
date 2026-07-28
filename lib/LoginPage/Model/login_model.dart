class LoginModel {
  int? status;
  String? message;
  LoginData? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
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

class LoginData {
  int? userId;
  String? userType;
  String? empCode;
  String? mobileNo;
  String? hq;
  String? region;
  String? userName;

  LoginData(
      {this.userId,
      this.userType,
      this.empCode,
      this.mobileNo,
      this.hq,
      this.region,
      this.userName});

  LoginData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userType = json['user_type'];
    empCode = json['emp_code'];
    mobileNo = json['mobile_no'];
    hq = json['hq'];
    region = json['region'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['emp_code'] = this.empCode;
    data['mobile_no'] = this.mobileNo;
    data['hq'] = this.hq;
    data['region'] = this.region;
    data['user_name'] = this.userName;
    return data;
  }
}
