class User {
  User({
    required this.status,
    required this.token,
    required this.message,
    required this.account,
  });
  late final String status;
  late final String token;
  late final String message;
  late final Account account;
  
  User.fromJson(Map<String, dynamic> json){
    status = json['status'];
    token = json['token'];
    message = json['message'];
    account = Account.fromJson(json['account']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['token'] = token;
    _data['message'] = message;
    _data['account'] = account.toJson();
    return _data;
  }
}

class Account {
  Account({
    required this.email,
    required this.accountStatus,
    required this.createdAt,
    required this.college,
    required this.name,
    required this.phoneNumber,
    required this.id,
  });
  late final String email;
  late final String accountStatus;
  late final String createdAt;
  late final String college;
  late final String name;
  late final int phoneNumber;
  late final String id;
  
  Account.fromJson(Map<String, dynamic> json){
    email = json['email'];
    accountStatus = json['accountStatus'];
    createdAt = json['createdAt'];
    college = json['college'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['accountStatus'] = accountStatus;
    _data['createdAt'] = createdAt;
    _data['college'] = college;
    _data['name'] = name;
    _data['phoneNumber'] = phoneNumber;
    _data['id'] = id;
    return _data;
  }
}


// class User {
//   String? status;
//   String? token;
//   String? message;
//   Account? account;

//   User({
//     this.status,
//     this.token,
//     this.message,
//     this.account,
//   });

  
//   User.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     token = json['token'];
//     message = json['message'];
//     account = Account.fromJson(json['account']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['token'] = token;
//     _data['message'] = message;
//     _data['account'] = account?.toJson();
//     return _data;
//   }
// }

// class Account {
//   String? email;
//   String? accountStatus;
//   String? createdAt;
//   String? college;
//   String? name;
//   int? phoneNumber;
//   String? id;

//   Account({
//     this.email,
//     this.accountStatus,
//     this.createdAt,
//     this.college,
//     this.name,
//     this.phoneNumber,
//     this.id,
//   });

  
//   Account.fromJson(Map<String, dynamic> json){
//     email = json['email'];
//     accountStatus = json['accountStatus'];
//     createdAt = json['createdAt'];
//     college = json['college'];
//     name = json['name'];
//     phoneNumber = json['phoneNumber'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['email'] = email;
//     _data['accountStatus'] = accountStatus;
//     _data['createdAt'] = createdAt;
//     _data['college'] = college;
//     _data['name'] = name;
//     _data['phoneNumber'] = phoneNumber;
//     _data['id'] = id;
//     return _data;
//   }
// }