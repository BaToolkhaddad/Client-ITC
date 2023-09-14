class NalysisInfoModel {
  int? id;
  String? itemsName;
  String? itemsNameEnglish;
  String? itemsDescription;
  String? itemsDescriptionEnglish;
  int? categoryId;
  Null createdAt;
  Null updatedAt;

  NalysisInfoModel(
      {this.id,
      this.itemsName,
      this.itemsNameEnglish,
      this.itemsDescription,
      this.itemsDescriptionEnglish,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  NalysisInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemsName = json['items_name'];
    itemsNameEnglish = json['items_name_english'];
    itemsDescription = json['items_description'];
    itemsDescriptionEnglish = json['items_description_english'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['items_name'] = itemsName;
    data['items_name_english'] = itemsNameEnglish;
    data['items_description'] = itemsDescription;
    data['items_description_english'] = itemsDescriptionEnglish;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}