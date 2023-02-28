import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp/constants/color.dart';
import 'package:phone_otp/screens/login_screen.dart';
import 'package:phone_otp/widgets/slide_dot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: double.maxFinite,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/glass.png',
                            height: double.maxFinite,
                          ),
                          Positioned(
                              top: 40,
                              right: 20,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: lowGrey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(50)),
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('assets/share.png'))),
                          Positioned(
                              top: 120,
                              right: 20,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: lowGrey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(50)),
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('assets/heart.png'))),
                        ],
                      ),
                    ),
                    Center(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideDots(true),
                        SlideDots(false),
                        SlideDots(false),
                        SlideDots(false),
                      ],
                    )),
                    const Text(
                      'Eyevy',
                      style: TextStyle(color: lowGrey, fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Full Rim Round, Cat-eyed Anti Glare Frame (48mm)',
                      style: TextStyle(color: lowGrey, fontSize: 21),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Text(
                          '₹ 219',
                          style: TextStyle(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '₹999',
                          style: TextStyle(
                              color: lowGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '78% off',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: double.maxFinite,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: const Center(
                                child: Text(
                              'ADD TO CART',
                              style: TextStyle(
                                color: black,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 60,
                            color: butColor,
                            child: const Center(
                                child: Text(
                              "BUY NOW",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                          )
                        ],
                      ),
                    )
                  ],
                );
              })),
    );
  }
}
