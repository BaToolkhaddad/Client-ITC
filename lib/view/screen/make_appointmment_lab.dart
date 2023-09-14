import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client_itc/view/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:provider/provider.dart';
import '../../../controller/make_appointment_controller.dart';
import '../../../core/constant/color.dart';
import '../../../functions/checkinternet.dart';
import '../../../helper/http_exception.dart';
import '../../controller/analyis_controller.dart';
import '../../model/nalysis_info.dart';
class   MakeAppointmentLabSecreen extends StatefulWidget {
  static const routeName = '/makeappointmentsecreen';
  const MakeAppointmentLabSecreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MakeAppointmentLabSecreenState createState() => _MakeAppointmentLabSecreenState();
}

class _MakeAppointmentLabSecreenState extends State<MakeAppointmentLabSecreen> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> makeAppointmentdata = {};
  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.leftSlide,
      desc:
          'فشل في إرسال الطلب , الرجاء التحقق من الاتصال بالانترنت و إعادة المحاولة ',
      descTextStyle: const TextStyle(
          color: AppColor.primaryColor, fontWeight: FontWeight.bold),
      btnOkIcon: Icons.check_circle,
      btnOkOnPress: () => Navigator.of(context)
          .pushReplacementNamed(MakeAppointmentLabSecreen.routeName),
      // ignore: use_build_context_synchronously
      btnOkColor: AppColor.primaryColor,
      onDismissCallback: (_) => Navigator.of(context)
          .pushReplacementNamed(MakeAppointmentLabSecreen.routeName),
    ).show();
  }
  
  Future<void> _submit() async {
    formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    if (formKey.currentState!.validate()) {
      try {
        print('makeAppointmentdata$makeAppointmentdata');
        await Provider.of<MakeAppointmentProvider>(context, listen: false)
            .makeAppointment(
          makeAppointmentdata['use_name'],
          makeAppointmentdata['user_old'],
          makeAppointmentdata['user_phone'],
          makeAppointmentdata['user_gender'],
          makeAppointmentdata['booking_status'],
          context: context,
        );
      } on HttpException catch (error) {
        var errorMessage = error.toString();
        _showErrorDialog(errorMessage);
      } catch (error) {
        var errorMessage = error.toString();
        _showErrorDialog(errorMessage);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  // ignore: prefer_typing_uninitialized_variables
  var res;

  intialdata() async {
    res = await checkInternet();
    print(res);
  }

  @override
  void initState() {
    intialdata();
    super.initState();
  }
 NalysisInfoModel? selectorDropDownValueAnalyis;
 
  
  Widget _buildTextFields() {
    final selectorAnalyis =
        Provider.of<InfoAnalyisProvider>(context, listen: false);

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: 'الإسم',
                  hintStyle: const TextStyle(fontSize: 14),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 9),
                      child: const Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  offset: Offset(9, 9),
                                  color: Colors.black38,
                                  blurRadius: 5),
                            ],
                            color: AppColor.primaryColor),
                      )),
                  suffixIcon: const Icon(
                    Icons.person_outlined,
                    color: AppColor.primaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'هذا الحقل فارغ';
                }
                return null;
              },
              onSaved: (value) {
                makeAppointmentdata['user_name'] = value;
              },
            ),
          ),
        ),

         Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: 'اسم الأب',
                  hintStyle: const TextStyle(fontSize: 14),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 9),
                      child: const Text(
                        'Father Name',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  offset: Offset(9, 9),
                                  color: Colors.black38,
                                  blurRadius: 5),
                            ],
                            color: AppColor.primaryColor),
                      )),
                  suffixIcon: const Icon(
                    Icons.person_outlined,
                    color: AppColor.primaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'هذا الحقل فارغ';
                }
                return null;
              },
              onSaved: (value) {
                makeAppointmentdata['user_name'] = value;
              },
            ),
          ),
        ),
        //_______________________________
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'العمر',
                  hintStyle: const TextStyle(fontSize: 14),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 9),
                      child: const Text(
                        'Old',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  offset: Offset(9, 9),
                                  color: Colors.black38,
                                  blurRadius: 5),
                            ],
                            color: AppColor.primaryColor),
                      )),
                  suffixIcon: const Icon(
                    Icons.date_range,
                    color: AppColor.primaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              // ignore: missing_return
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                makeAppointmentdata['user_old'] = value;
              },
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: 'الجنس',
                  hintStyle: const TextStyle(fontSize: 14),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 9),
                      child: const Text(
                        'Gender',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  offset: Offset(9, 9),
                                  color: Colors.black38,
                                  blurRadius: 5),
                            ],
                            color: AppColor.primaryColor),
                      )),
                  suffixIcon: const Icon(
                    Icons.group,
                    color: AppColor.primaryColor,
                                        ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                makeAppointmentdata['user_gender'] = value;
              },
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
             
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: 'رقم الهاتف',
                  hintStyle: const TextStyle(fontSize: 14),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 9),
                      child: const Text(
                        'Number Phone',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  offset: Offset(9, 9),
                                  color: Colors.black38,
                                  blurRadius: 5),
                            ],
                            color: AppColor.primaryColor),
                      )),
                  suffixIcon: const Icon(
                    Icons.ad_units,
                    color: AppColor.primaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                makeAppointmentdata['user_phone'] = value;
              },
            ),
          ),
        ),
         Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: 'اسم التحليل',
                  hintStyle: const TextStyle(fontSize: 14),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 9),
                      child:DropdownButton<NalysisInfoModel>(
                                                
                                                icon: const Icon(
                                                    Icons.arrow_downward),
                                                value: selectorDropDownValueAnalyis,
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.purple[50],
                                                ),
                                                onChanged: (NalysisInfoModel? newValue) {
                                                  setState(() {
                                                     selectorDropDownValueAnalyis = newValue!;
                                                  });
                                                   selectorDropDownValueAnalyis == null ?"" : newValue;
                                                },
                                                 items: selectorAnalyis.infoAnalyis
                                                 
                                                .map<
                                                    DropdownMenuItem<NalysisInfoModel>>((value) {
                                                  return DropdownMenuItem<
                                                      NalysisInfoModel>(
                                                    value: value,
                                                    child: Text(value.itemsName!),
                                                    
                                                  );
                                                }).toList(),
                                              ),),
                  suffixIcon: const Icon(
                    Icons.app_registration,
                    color: AppColor.primaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'هذا الحقل فارغ';
                }
                return null;
              },
              onSaved: (value) {
                makeAppointmentdata['user_name'] = value;
              },
            ),
          ),
        ),

        _submitButton(),
          const SizedBox(height: 50,)
      ],
    );
  }

  Widget _submitButton() {
    return Container(
      decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            topLeft: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 5),
                color: AppColor.primaryColor,
                spreadRadius: 2,
                blurRadius: 5),
          ]),
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * .09,
      // margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : TextButton(
              onPressed: _submit,
              child: const Text(
                'إرسال الطلب',
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  shadows: [
                    Shadow(
                        offset: Offset(4, 2),
                        color: Colors.white38,
                        blurRadius: 3),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GFAppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text(
                        '       حجز موعد',
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          shadows: [
                            Shadow(
                                offset: Offset(4, 2),
                                color: Colors.white38,
                                blurRadius: 3),
                          ],
                        ),
                      ),
         iconTheme: const IconThemeData(
            color: AppColor.white,
            shadows: [
              Shadow(
                  offset: Offset(3, 3), color: Colors.white38, blurRadius: 3),
            ],
            size: 30),
        
        ),
        drawer: const AppDrawer(),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.primaryColor,
                      AppColor.white,
                    ]),
              ),
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                            height: MediaQuery.of(context).size.height * .9,
                            decoration: const BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(70),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Icon(Icons.list_alt_outlined,
                                          color: AppColor.primaryColor,
                                          size: 70,
                                          shadows: [
                                            BoxShadow(
                                                offset: Offset(1, 5),
                                                color: Colors.black38,
                                                spreadRadius: 2,
                                                blurRadius: 5),
                                          ]),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(child: _buildTextFields()),

                                      //  const SizedBox(
                                      //   height: 20,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ))),
                    const SizedBox(
                      height: 20,
                    ),
                  ]))),
        ));
  }
}
