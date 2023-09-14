
import 'package:client_itc/view/screen/select_type.dart';
import 'package:flutter/material.dart';
import '../../../controller/auth_controller.dart';
import '../../../core/constant/color.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../abbpar_bottom.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _authdata = {};
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          
              title: const Text('فشل عملية تسجيل الدخول' , style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold),),
              content: const Text('يرجى التحقق من وجود اننرنت أو إدخال البيانات بشكل صحيح و ثم أعد المحاولة'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            ));
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
        Navigator.of(context).pushReplacementNamed(AbbParBottom.routeName);
      },
      btnOkColor: AppColor.primaryColor,
      onDismissCallback: (_) {
        Navigator.of(context).pushReplacementNamed(SelectType.routeName);
      },
    ).show();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).login(
        _authdata['user_ident'],
        _authdata['user_password'],
      );
      _showSuccessDialog('تم تسجيل الدخول');
    } catch (error) {
      var errorMessage = error.toString();
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }
  bool _obscureText = true;
  Widget _passwordTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          obscureText: _obscureText,
          textDirection: TextDirection.ltr,
          keyboardType: TextInputType.text,
          
          decoration:InputDecoration(
            hintText: 'كلمة السر',
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: const Text('PassWord', style: TextStyle(
              fontSize: 17,
            fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    offset: Offset(9, 9), color: Colors.black38, blurRadius: 5),
              ],
              color: AppColor.primaryColor),)),
                suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off , color: AppColor.primaryColor,),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    
          // ignore: missing_return
          validator: (value) {
            if (value!.isEmpty || value.length < 7) {
              return 'كلمة السر قصيرة جدا';
            }
            return null;
          },
          onSaved: (value) {
            _authdata['user_password'] = value;
          },
        ),
      ),
    );
  }

  Widget _phoneNumberTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
           
              
          keyboardType: TextInputType.phone,

          decoration:InputDecoration(
            hintText: 'الرقم الوطني',
  floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: const Text('Id', style: TextStyle(
              fontSize: 17,
            fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    offset: Offset(9, 9), color: Colors.black38, blurRadius: 5),
              ],
              color: AppColor.primaryColor),)),
            suffixIcon: const Icon(Icons.abc, color: AppColor.primaryColor,),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          
          // ignore: missing_return
          validator: (value) {
            if (value!.isEmpty) {
              return 'هذا الحقل فارغ';
            }
            return null;
          },
          onSaved: (value) {
            _authdata['user_ident'] = value;
          },
        ),
      ),
    );
  }


  

  // Widget _forgetPassword() {
  //   return Container(
  //     alignment: Alignment.centerLeft,
  //     child: TextButton(
  //       onPressed: () => {
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => const EditProfile()))
  //       },
  //       child: const Text('نسيت كلمة السر؟',
  //           style:TextStyle(
  //               color: AppColor.primaryColor,
  //               fontWeight: FontWeight.bold,
  //               fontSize: 20,
  //               shadows: [
  //                 Shadow(
  //                     offset: Offset(4, 2),
  //                     color: Colors.white38,
  //                     blurRadius: 3),
  //               ],
  //             ),),
  //     ),
  //   );
  // }

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
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: _isLoading == false
          ? TextButton(
              onPressed: _submit,
              child: const Text(
                'تسجيل دخول',
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final auth = Provider.of<Auth>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: auth.isAuth
          ? AbbParBottom()
          : SingleChildScrollView(
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
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'Login',
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
                    height: MediaQuery.of(context).size.height * .9,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child:SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(Icons.person,
                                color: AppColor.primaryColor,
                                size: 100,
                                shadows: [
                                  BoxShadow(
                                      offset: Offset(1, 5),
                                      color: Colors.black38,
                                      spreadRadius: 2,
                                      blurRadius: 5),
                                ]),
                            SizedBox(
                              height: deviceHeight * .06,
                            ),
                            _phoneNumberTextField(),
                            _passwordTextField(),
                            _submitButton(),
                           
                          ],
                        ),
                      ),
                    ),
                  )
               ) )])))));
  }
}
