import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:flutter/material.dart';

class OtherInformationCard extends StatefulWidget {
  final IconData icon;
  final String title;
  const OtherInformationCard({super.key, required this.icon, required this.title});

  @override
  State<OtherInformationCard> createState() => _OtherInformationCardState();
}

class _OtherInformationCardState extends State<OtherInformationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(AppColors.primaryColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(widget.icon, size: 20,),
                  Text(
                    widget.title
                  )
                ],
              ),
              const Icon(Icons.arrow_circle_down_rounded, color: Colors.grey, size: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
