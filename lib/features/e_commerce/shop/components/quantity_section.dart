import 'package:flutter/material.dart';

class QuantitySection extends StatefulWidget {
  final double totalPrice;
  final Function(double) onQuantityChanged;
  const QuantitySection({super.key, required this.totalPrice, required this.onQuantityChanged});

  @override
  State<QuantitySection> createState() => _QuantitySectionState();
}

class _QuantitySectionState extends State<QuantitySection> {
  int initialCount = 0;
  @override
  Widget build(BuildContext context) {
    double productPrice = widget.totalPrice;
    double totalPrice = productPrice * initialCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quantity",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),
        ),
        const SizedBox(height: 5,),
        Row(
          children: [
            GestureDetector(
              onTap: (){
                if (initialCount == 0) {
                  return;
                } else {
                  setState(() {
                    initialCount -=1;
                    widget.onQuantityChanged(-productPrice.toDouble());
                  });
                }
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle
                ),
                child: const Center(
                  child: Icon(Icons.remove, size: 18,),
                ),
              ),
            ),
            Text(
              " $initialCount "
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  initialCount += 1;
                  widget.onQuantityChanged(productPrice.toDouble());
                });
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 18,),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
