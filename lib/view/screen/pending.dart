import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client_itc/core/constant/color.dart';
import 'package:client_itc/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import '../../model/order.dart';


class OrdersPending extends StatefulWidget {
  static String routeName = '/orderpendeing';
  
  const OrdersPending({super.key});

  @override
  State<OrdersPending> createState() => _OrdersPendingState();
}

class _OrdersPendingState extends State<OrdersPending> {
   late final OrderModel listdata;
  @override
  Widget build(BuildContext context) {
    
  final message =ModalRoute.of(context)!.settings.arguments;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: const Text(
          '           طلباتي',
          style: TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            shadows: [
              Shadow(
                  offset: Offset(5, 5), color: Colors.black38, blurRadius: 5),
            ],
          ),
        ),
      
        iconTheme: const IconThemeData(
            color: AppColor.primaryColor,
            shadows: [
              Shadow(
                  offset: Offset(3, 3), color: Colors.black38, blurRadius: 3),
            ],
            size: 30),
      ),
      //  bottomNavigationBar: AbbParBottom(),
      // drawer: const AppDrawer(),
      body: Container(
          height: h ,
             decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.primaryColor,
                      AppColor.white,
                    ]),
              ),
          padding: const EdgeInsets.all(10),
          child:  ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) => Column(children: [
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                    color: AppColor.blue,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                    ),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                       
                        children: [
                          Text("   الاسم : ${orderList[0].name}",
                              style: const TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const Spacer(),
                          // Text(listdata.ordersDatetime!)
                          // Text(
                          //   Jiffy(listdata.ordersDatetime!, "yyyy-MM-dd").fromNow(),
                          //   style: const TextStyle(
                          //       color: AppColor.primaryColor,
                          //       fontWeight: FontWeight.bold),
                          // )
                        ],
                      ),
                      const Divider(),
                      Text("العمر : ${orderList[0].age}"),
                      Text("رقم الهاتف : ${orderList[0].phone} "),
                      Text("الحجز في : ${orderList[0].clinicorlab} \$ "),
                      Text("الحالة : ${orderList[0].status} "),
                      const Divider(),
                      Row(
                        children: [
                          MaterialButton(
                            clipBehavior: Clip.antiAlias,
                            onPressed: () {
                              AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.leftSlide,
      desc: 'تأكيد عملية إلغاء الموعد',
      descTextStyle: const TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            shadows: [
              Shadow(
                  offset: Offset(5, 5), color: Colors.black38, blurRadius: 5),
            ],
          ),
      btnOkIcon: Icons.check_circle,
      btnOkOnPress: () {
        Navigator.of(context).pushReplacementNamed(OrdersPending.routeName);
      },
      btnOkColor: Theme.of(context).primaryColor,
      onDismissCallback: (_) {
        Navigator.of(context).pushReplacementNamed(OrdersPending.routeName);
      },
    ).show();
                            },
                            color: AppColor.primaryColor,
                            textColor: AppColor.primaryColor,
                            child: const Text("إالغاء" , style: TextStyle(color: AppColor.blue),),
                          ),
                          const Spacer(),
                          const Text(" : هل تريد إلغاء الحجز  ",
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          //  if (listdata.ordersStatus! == "0") MaterialButton(
                          //     onPressed: () {
                          //       controller.deleteOrder(listdata.ordersId!);
                          //     },
                          //     color: AppColor.thirdColor,
                          //     textColor: AppColor.secondColor,
                          //     child: const Text("Delete"),
                          //   )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]))
          
          ),
    );
  }
}
