import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/shared_components/custom_back_button.dart';
import 'package:e_store/utilities/shared_components/custom_button.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        automaticallyImplyLeading: false,
        leading: CustomBackButton(buildContext: context),
        centerTitle: true,
        leadingWidth: 90,
        title: const Text("Checkout", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Saved Card", style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                        ),),
                        SizedBox(
                          height: 45,
                            width: 45,
                            child: Image.asset("images/mastercard_credit_card.png"))
                      ],
                    ),
                    const Spacer(),
                    const Text(
                      "234  567  890  023  0940",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const Spacer(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                            "Holder",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13
                            ),
                          ),
                          Text(
                            "Demo Users",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expire",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                              ),
                            ),
                            Text(
                              "07/36",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CVV",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                              ),
                            ),
                            Text(
                              "009",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomButton(title: "Pay", onClick: (){})
          ],
        ),
      ),
    );
  }
}
