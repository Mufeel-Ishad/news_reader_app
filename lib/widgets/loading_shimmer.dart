import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 6, // Show 6 shimmer cards
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simulated image
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                ),
                // Simulated text lines
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      Container(height: 14, width: 100, color: Colors.grey),
                      const SizedBox(height: 12),
                      Container(
                        height: 12,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 6),
                      Container(height: 12, width: 200, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
