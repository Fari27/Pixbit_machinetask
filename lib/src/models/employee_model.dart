class ViewEmployeeModel {
  Data? data;

  ViewEmployeeModel({this.data});

  ViewEmployeeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Employee {
  int? id;
  String? firstName;
  String? lastName;
  String? joinDate;
  String? dateOfBirth;
  int? designationId;
  String? gender;
  int? mobile;
  int? landline;
  String? email;
  String? presentAddress;
  String? permanentAddress;
  String? profilePicture;
  String? resume;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? profileImage;

  Employee(
      {this.id,
      this.firstName,
      this.lastName,
      this.joinDate,
      this.dateOfBirth,
      this.designationId,
      this.gender,
      this.mobile,
      this.landline,
      this.email,
      this.presentAddress,
      this.permanentAddress,
      this.profilePicture,
      this.resume,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.profileImage});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    joinDate = json['join_date'];
    dateOfBirth = json['date_of_birth'];
    designationId = json['designation_id'];
    gender = json['gender'];
    mobile = json['mobile'];
    landline = json['landline'];
    email = json['email'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    profilePicture = json['profile_picture'];
    resume = json['resume'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['join_date'] = this.joinDate;
    data['date_of_birth'] = this.dateOfBirth;
    data['designation_id'] = this.designationId;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['landline'] = this.landline;
    data['email'] = this.email;
    data['present_address'] = this.presentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['profile_picture'] = this.profilePicture;
    data['resume'] = this.resume;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}