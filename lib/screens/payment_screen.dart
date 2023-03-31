import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:kfccheck/common/const.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethod();
}

class _PaymentMethod extends State<PaymentMethod> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Stack(children: [
                    Container(
                      width: 414,
                      height: 206,
                      decoration: const BoxDecoration(color: kala),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 60, left: 10),
                        child: Text(
                          'Payment',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Dgreen),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 629,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            color: gray,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Card Number',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kala),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 75,
                                      height: 33,
                                      decoration:
                                          BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(4)), border: Border.all(color: lGrey)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(19),
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: "****",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 75,
                                      height: 33,
                                      decoration:
                                          BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(4)), border: Border.all(color: lGrey)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(19),
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: "****",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 75,
                                      height: 33,
                                      decoration:
                                          BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(4)), border: Border.all(color: lGrey)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(19),
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: "****",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 75,
                                      height: 33,
                                      decoration:
                                          BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(4)), border: Border.all(color: lGrey)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(19),
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: "****",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
