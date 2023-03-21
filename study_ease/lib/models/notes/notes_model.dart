class NotesModel {
  NotesModel({
    required this.status,
    required this.notes,
    required this.total,
  });
  late final String status;
  late final List<Notes> notes;
  late final int total;
  
  NotesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    notes = List.from(json['notes']).map((e)=>Notes.fromJson(e)).toList();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['notes'] = notes.map((e)=>e.toJson()).toList();
    _data['total'] = total;
    return _data;
  }
}

class Notes {
  Notes({
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.subject,
    required this.isVerified,
    required this.uploadedAt,
    required this.uploadedBy,
    required this.downloadLink,
    required this.id,
    required this.views
  });
  late final String title;
  late final String shortDescription;
  late final String description;
  late final String subject;
  late final bool isVerified;
  late final String uploadedAt;
  late final UploadedBy uploadedBy;
  late final String downloadLink;
  late final String id;
  late final int views;
  
  Notes.fromJson(Map<String, dynamic> json){
    title = json['title'];
    shortDescription = json['shortDescription'];
    description = json['description'];
    subject = json['subject'];
    isVerified = json['isVerified'];
    uploadedAt = json['uploadedAt'];
    uploadedBy = UploadedBy.fromJson(json['uploadedBy']);
    downloadLink = json['downloadLink'];
    views = json['views'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['shortDescription'] = shortDescription;
    _data['description'] = description;
    _data['subject'] = subject;
    _data['isVerified'] = isVerified;
    _data['uploadedAt'] = uploadedAt;
    _data['uploadedBy'] = uploadedBy.toJson();
    _data['downloadLink'] = downloadLink;
    _data['views'] = views;
    _data['id'] = id;
    return _data;
  }
}

class UploadedBy {
  UploadedBy({
    required this.email,
    required this.accountStatus,
    required this.createdAt,
    // required this._V,
    required this.college,
    required this.name,
    required this.phoneNumber,
    required this.id,
  });
  late final String email;
  late final String accountStatus;
  late final String createdAt;
  // late final int _V;
  late final String college;
  late final String name;
  late final int phoneNumber;
  late final String id;
  
  UploadedBy.fromJson(Map<String, dynamic> json){
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