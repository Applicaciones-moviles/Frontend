import 'package:carconnect_aplication/base/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CarCatalogue extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String rentalCost;

  const CarCatalogue({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.rentalCost,
  });

  ImageProvider _getImageProvider() {
    try {
      if (imageUrl.startsWith('assets/')) {
        return AssetImage(imageUrl);
      }
      return NetworkImage(imageUrl);
    } catch (e) {
      return const AssetImage('assets/images/car.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 95,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image(
                image: _getImageProvider(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/car.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "S/.$rentalCost",
                  textAlign: TextAlign.left,
                  style: AppStyles.headLineStyle4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}