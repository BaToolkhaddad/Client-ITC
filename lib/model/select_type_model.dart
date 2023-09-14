class SelectTypeModel {
  String? categoriesId;
  String? categoriesName;
  String? categoriesImage;
  String? categoriesNameEnglish;

  SelectTypeModel(
      {this.categoriesId,
      this.categoriesName,
      this.categoriesImage,
      this.categoriesNameEnglish});

  SelectTypeModel.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesImage = json['categories_image'];
    categoriesNameEnglish = json['categories_name_english'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories_id'] = categoriesId;
    data['categories_name'] = categoriesName;
    data['categories_image'] = categoriesImage;
    data['categories_name_english'] =categoriesNameEnglish;
    return data;
  }
}