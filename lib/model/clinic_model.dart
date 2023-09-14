class ClinicModel {
  int? id;
  String? clinicName;
  String? clinicNameEnglish;
  Null createdAt;
  Null updatedAt;
  Null image;

   String? getImageUrl() {
    return image?.url;
  }

  ClinicModel(
      {this.id,
      this.clinicName,
      this.clinicNameEnglish,
      this.createdAt,
      this.updatedAt,
      this.image
      });

  ClinicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicName = json['clinic_name'];
    clinicNameEnglish = json['clinic_name_english'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clinic_name'] = clinicName;
    data['clinic_name_english'] = clinicNameEnglish;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    return data;
  }
}