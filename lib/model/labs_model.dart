class LabsModel {
  int? id;
  String? laboratoriesName;
  String? laboratoriesLocation;
  String? laboratoriesDescribe;
  String? labLicenseImage;
  String? labLicenseNumber;
  Null createdAt;
  Null updatedAt;
  Image? image;

   String? getImageUrl() {
    return image?.url;
  }

  LabsModel(
      {this.id,
      this.laboratoriesName,
      this.laboratoriesLocation,
      this.laboratoriesDescribe,
      this.labLicenseImage,
      this.labLicenseNumber,
      this.createdAt,
      this.updatedAt,
      this.image});

  LabsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    laboratoriesName = json['Laboratories_name'];
    laboratoriesLocation = json['Laboratories_location'];
    laboratoriesDescribe = json['Laboratories_describe'];
    labLicenseImage = json['lab_license_image'];
    labLicenseNumber = json['lab_license_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Laboratories_name'] = this.laboratoriesName;
    data['Laboratories_location'] = this.laboratoriesLocation;
    data['Laboratories_describe'] = this.laboratoriesDescribe;
    data['lab_license_image'] = this.labLicenseImage;
    data['lab_license_number'] = this.labLicenseNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Image {
  int? id;
  String? imageableType;
  int? imageableId;
  String? url;
  Null createdAt;
  Null updatedAt;

  Image(
      {this.id,
      this.imageableType,
      this.imageableId,
      this.url,
      this.createdAt,
      this.updatedAt});
 

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageableType = json['imageable_type'];
    imageableId = json['imageable_id'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageable_type'] = this.imageableType;
    data['imageable_id'] = this.imageableId;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
    
  }
  
}