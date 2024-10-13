import 'package:e_store/features/account/components/quick_actions_button.dart';
import 'package:e_store/features/account/screens/terms_and_conditions_screen.dart';
import 'package:e_store/features/auth/model/user_provider.dart';
import 'package:e_store/features/auth/sing_in/screens/sign_in_screen.dart';
import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/shared_components/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).userModel;
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        surfaceTintColor: const Color(AppColors.whiteColor),
        leadingWidth: 90,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: CustomBackButton(buildContext: context),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Hero(
                tag: 'name->${user.firstName}--${user.lastName[0]}',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                        color: Color(AppColors.primaryColor),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        "${user.firstName[0]}${user.lastName[0]}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "${user.firstName} ${user.lastName}",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Text(
                user.email,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Active",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.green,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              QuickActionsButton(
                  title: "Order", iconData: IconlyLight.bag_2, onClick: () {}),
              QuickActionsButton(
                  title: "Edit Profile",
                  iconData: IconlyLight.profile,
                  onClick: () {}),
              QuickActionsButton(
                  title: "Language",
                  iconData: IconlyLight.play,
                  onClick: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Default language is set to english")));
                  }),
              QuickActionsButton(
                  title: "Terms & Condition",
                  iconData: IconlyLight.message,
                  onClick: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const TermsAndConditionsScreen()));
                  }),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                      (route) => false);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
