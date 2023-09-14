import 'package:client_itc/view/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/auth_controller.dart';
import '../../../core/constant/color.dart';
import '../../../functions/checkinternet.dart';
import '../../../helper/http_exception.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _authdata = {};
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('فشل عملية إنشاء الحساب '),
        content: Text(message),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ],
      ),
    );
  }


  Widget loginLabel() {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'تسجيل دخول',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              shadows: [
                Shadow(
                  offset: Offset(4, 2),
                  color: Colors.white38,
                  blurRadius: 3,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            ' !لديك حساب ؟',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 20,
              shadows: [
                Shadow(
                  offset: Offset(4, 2),
                  color: Colors.white38,
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  Future<void> _submit() async {
  formKey.currentState!.save();
  setState(() {
    isLoading = true;
  });

  if (formKey.currentState!.validate()) {
    try {
      print('auttthdataaaaa$_authdata');
       await Provider.of<Auth>(context, listen: false).signup(
        _authdata['user_name'],
        _authdata['user_phone'],
        _authdata['user_ident'],
        _authdata['user_password'],
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

  bool _obscureText = true;
  Widget _buildTextFields() {
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration:InputDecoration(
            hintText: 'الإسم الكامل',
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: const Text('Full Name', style: TextStyle(
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
                
      
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'هذا الحقل فارغ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authdata['user_name'] = value;
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
                  keyboardType: TextInputType.phone,
                  decoration:InputDecoration(
            hintText: 'رقم الهاتف',
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: const Text('Number phone', style: TextStyle(
              fontSize: 17,
            fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    offset: Offset(9, 9), color: Colors.black38, blurRadius: 5),
              ],
              color: AppColor.primaryColor),)),
            suffixIcon: const Icon(Icons.phone_android, color: AppColor.primaryColor,),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                  // ignore: missing_return
                  validator: (value) {
                    if (value!.isEmpty || value.length < 10) {
                      return 'رقم الهانف يجب أن يكون 10 أرقام ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authdata['user_phone'] = value;
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
                  keyboardType: TextInputType.number,
                  decoration:InputDecoration(
            hintText: 'الرقم الوطني',
            hintStyle: const TextStyle(fontSize: 14),
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
                 
                  validator: (value) {
                    if (value!.isEmpty || value.length <11) {
                      return 'رقم الهوية يجب أن يكون 11 رقم';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authdata['user_ident'] = value;
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
            suffixIcon:  IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off , color: AppColor.primaryColor,),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });}),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                 
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return 'كلمة السر قصيرة جدا';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authdata['user_password'] = value;
                  },
                ),
              ),
            ),
          ],
        ));
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
                'إنشاء حساب',
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
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'Register',
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
               child: Container(
                    height: MediaQuery.of(context).size.height * .9,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                           const Icon(Icons.person,
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
                              height: 10,
                            ),
                            Container(child: _buildTextFields()),
                            
                            _submitButton(),
                           loginLabel()
                          ],
                        ),
                      ),
                    ),
                  )
               ) )])))));
  }
}
