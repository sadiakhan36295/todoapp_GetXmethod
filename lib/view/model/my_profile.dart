class myprofile_model {
  bool? success;
  String? message;
  Data? data;

  myprofile_model({this.success, this.message, this.data});

  myprofile_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Verification? verification;
  String? sId;
  String? status;
  String? name;
  String? email;
  String? address; // ✅ Add this line
  String? phoneNumber;
  String? password;
  String? profile;
  String? role;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.verification,
    this.sId,
    this.status,
    this.name,
    this.email,
    this.address, // ✅ Add to constructor
    this.phoneNumber,
    this.password,
    this.profile,
    this.role,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    verification = json['verification'] != null
        ? Verification.fromJson(json['verification'])
        : null;
    sId = json['_id'];
    status = json['status'];
    name = json['name'];
    email = json['email'];
    address = json['address']; // ✅ Parse it from JSON
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    profile = json['profile'];
    role = json['role'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (verification != null) data['verification'] = verification!.toJson();
    data['_id'] = sId;
    data['status'] = status;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address; // ✅ Include in toJson
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['profile'] = profile;
    data['role'] = role;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}


class Verification {
  int? otp;
  bool? status;

  Verification({this.otp, this.status});

  Verification.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['status'] = this.status;
    return data;
  }
}