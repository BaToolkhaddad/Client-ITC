class MakeAppointmentModel {
  String? useName;
  String? userOld;
  String? userPhone;
  int? userGender;
  int? bookingStatus;
  String? bookingDate;
  String? bookingDatetime;
  int? doctorId;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  MakeAppointmentModel(
      {this.useName,
      this.userOld,
      this.userPhone,
      this.userGender,
      this.bookingStatus,
      this.bookingDate,
      this.bookingDatetime,
      this.doctorId,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  MakeAppointmentModel.fromJson(Map<String, dynamic> json) {
    useName = json['use_name'];
    userOld = json['user_old'];
    userPhone = json['user_phone'];
    userGender = json['user_gender'];
    bookingStatus = json['booking_status'];
    bookingDate = json['booking_date'];
    bookingDatetime = json['booking_datetime'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['use_name'] = useName;
    data['user_old'] = userOld;
    data['user_phone'] = userPhone;
    data['user_gender'] = userGender;
    data['booking_status'] = bookingStatus;
    data['booking_date'] = bookingDate;
    data['booking_datetime'] = bookingDatetime;
    data['doctor_id'] = doctorId;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}