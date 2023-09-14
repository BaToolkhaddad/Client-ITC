
import 'package:client_itc/model/order.dart';

import '../../../core/constant/imgaeasset.dart';
import '../../../model/onboardingmodel.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      title: "! لمحة عن التطبيق ",
      body:
          'كل ما تحتاجه طبيا\n( معلومات , خدمات ,استفسارات )  \nنوفره لك في تطبيقنا ',
      image: AppImageAsset.onBoardingImage3),
  OnBoardingModel(
      title: "! لمحة عن التطبيق ",
      body:
          'يهدف هذا التطبيق لتقديم خدمات و تسهيلات كبيرة في إيجاد \nأقرب (مخبر تحاليل , عيادة , مركز تصوير) لديك \nو أنسب الأسعار لك من خلال التواصل معنا',
      image: AppImageAsset.onBoardingImage3),
];





List<OrderModel> orderList = [
  OrderModel(
    name: "علاء عساف",
    age: '30',
    phone: '0999999999',
    clinicorlab: 'مخبر غاردينيا',
    status: 'الطلب معلق',
  ),
];

String? dropdownValuecity = 'المدينة';
List<String> dropdownItemsCity = <String>[
  'المدينة',
  'حمص',
  'حماه',
  'دمشق',
  'حلب',
  'الاذقية',
  'طرطوس',
];

String? dropdownValueTech = 'الجنس';
List<String> dropdownItemsTech = <String>[
  'الجنس',
  'ذكر',
  'أنثى',
];

String? dropdownValueClinic = 'اختر عيادة';
List<String> dropdownItemsClinic = <String>[
  'اختر عيادة',
  'جراحة عامة',
  'جراحة أوعية',
  'جراحة صدرية',
  'جراحة تجميلية',
  'القلبية',
  'العينية',
  'الأذنية',
  'الهضمية',
  'العظمية',
  'النسائية',
  'الجلدية',
  'داخلية',
  'الأطفال',
  'البولية',
  'الكلية',
  'طب أسرة',
  'الغدد',
];
