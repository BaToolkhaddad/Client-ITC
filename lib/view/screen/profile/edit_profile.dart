import 'package:awesome_dialog/awesome_dialog.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:client_itc/core/constant/color.dart';
import '../../../controller/auth_controller.dart';
import '../../../model/profile.dart';

class EditProfile extends StatefulWidget {
   static const routeName = '/editprofile';
  const EditProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Column buildDisplayNameField(Profile profiledata) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: profiledata.currentUser!.name,
              //errorText: _displayFirstNameValid ? null : "الحقل فارغ",
               floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: const Text('الإسم الكامل', style: TextStyle(
              fontSize: 17,
            fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    offset: Offset(9, 9), color: Colors.black38, blurRadius: 5),
              ],
              color: AppColor.primaryColor),)),
            suffixIcon: const Icon(Icons.person_outlined, color: AppColor.primaryColor,),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
            ),
          
        ),
      ],
    );
  }

  Column buildPhoneField(Profile profiledata) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: phoneController,
            decoration: InputDecoration(
              hintText: profiledata.currentUser!.userPhone,
              //errorText: _phoneValid ? null : "الحقل فارغ",
               floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: const Text('رقم الهاتف', style: TextStyle(
              fontSize: 17,
            fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    offset: Offset(9, 9), color: Colors.black38, blurRadius: 5),
              ],
              color: AppColor.primaryColor),)),
            suffixIcon: const Icon(Icons.phone_android, color: AppColor.primaryColor,),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))
            ),
          ),
        )
      ],
    );
  }

  Column buildIdField(Profile profiledata) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: idController,
            decoration: InputDecoration(
              hintText: profiledata.currentUser!.userIdent,
               floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: const Text('الرقم الوطني', style: TextStyle(
              fontSize: 17,
            fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    offset: Offset(9, 9), color: Colors.black38, blurRadius: 5),
              ],
              color: AppColor.primaryColor),)),
            suffixIcon: const Icon(Icons.abc, color: AppColor.primaryColor,),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))
            ),
          ),
        )
      ],
    );
  }
 bool _obscureText = true;
  Column buildPasswordField(Profile profiledata) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            keyboardType: TextInputType.name,
            controller: passwordController,
            decoration: InputDecoration(
              hintText: profiledata.currentUser!.userPassword,
               floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: const Text('كلمة السر', style: TextStyle(
              fontSize: 17,
            fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    offset: Offset(9, 9), color: Colors.black38, blurRadius: 5),
              ],
              color: AppColor.primaryColor),)),
          suffixIcon:  IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off , color: AppColor.primaryColor,),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });}),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))
            ),
          ),
        )
      ],
    );
  }


  
  void _showSuccessDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.leftSlide,
      desc: message,
      descTextStyle: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 20,
            shadows: [
              Shadow(
                  offset: Offset(5, 5), color: Colors.black38, blurRadius: 5),
            ],),
      btnOkIcon: Icons.check_circle,
      btnOkOnPress: () {
        Navigator.of(context).pop();
      },
     
    ).show();
  }


void _showErorrDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.leftSlide,
      desc: message,
      descTextStyle: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 20,
            shadows: [
              Shadow(
                  offset: Offset(5, 5), color: Colors.black38, blurRadius: 5),
            ],),
      btnOkIcon: Icons.check_circle,
      btnOkOnPress: () {
        Navigator.of(context).pop();
      },
     
    ).show();
  }


updateProfileData(Profile profiledata) async {
 
  try {
    await Provider.of<Profile>(context, listen: false).updateOwnerInfo(
      id: Provider.of<Auth>(context, listen: false).token,
      userName: nameController.text.isEmpty
          ? profiledata.currentUser!.name
          : nameController.text,
      userIdent: idController.text.isEmpty
          ? profiledata.currentUser!.userIdent
          : idController.text,
      userPhone: phoneController.text.isEmpty
          ? profiledata.currentUser!.userPhone
          : phoneController.text,
      userPassword: passwordController.text.isEmpty
          ? profiledata.currentUser!.userPassword
          : passwordController.text,
    ).then((_) => _showSuccessDialog('تم تعديل بيانات ملفك الشخصي بنجاح '));
  } catch (error) {
_showErorrDialog('حدث خطأ أثناء إدخال بياناتك , الرجاء المحاولة ثانية !');
  }
}

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<Profile>(context, listen: false);

    return Scaffold(
      body:SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
               child:   Container(
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
            child: Column(children: [
      
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'تعديل الملف الشخصي',
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
               child:   Container(
                    height: MediaQuery.of(context).size.height * .79,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                      ),
                    ),
                    child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
               child:  Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20,),
              const Icon( IconData(0xf5d6, fontFamily: 'MaterialIcons' ,),
         color: AppColor.primaryColor,
                                size: 70,
                                shadows: [
                                  BoxShadow(
                                      offset: Offset(1, 5),
                                      color: Colors.black38,
                                      spreadRadius: 2,
                                      blurRadius: 5),
                                ]
       ),
              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20),
                child:SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
               child:  Column(
                
                  children: <Widget>[
                    const SizedBox(height: 30,),
                    buildDisplayNameField(profileData),
                    const SizedBox(height: 15,),
                    buildPhoneField(profileData),
                    const SizedBox(height: 15,),
                    buildIdField(profileData),
                    const SizedBox(height: 15,),
                    buildPasswordField(profileData),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
           width: 120,
            decoration:  const BoxDecoration(
               borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
             color: AppColor.white,
             boxShadow: [
               BoxShadow(
        color: AppColor.primaryColor,
        spreadRadius: 3,
        blurRadius: 3,
        offset: Offset(2, 2), // changes position of shadow
      ),
             ]
            ),
                   child: TextButton.icon(
                        onPressed: () => updateProfileData(profileData),
                        icon: const Icon(Icons.check, color: Colors.green),
                        label: const Text(
                          "حفظ",
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                 ),
                  const SizedBox(width: 50,),
                  Container(
                      width: 120,
            decoration:  const BoxDecoration(
               borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
             color: AppColor.white,
             boxShadow: [
               BoxShadow(
        color: AppColor.primaryColor,
        spreadRadius: 3,
        blurRadius: 3,
        offset: Offset(2, 2), // changes position of shadow
      ),
             ]
            ),
                    child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    label: const Text(
                      "إلغاء",
                      style: TextStyle(
                        color: AppColor.primaryColor,
                         fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                                  ),
                  ),
                ],
              ),
              
            ],
          ),
                )))],))
    ));
   
  }
}
