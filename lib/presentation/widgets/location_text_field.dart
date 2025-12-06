
import 'package:flutter/material.dart';

class LocationTextField extends StatelessWidget {
  const LocationTextField({
    super.key,
    required TextEditingController searchKey,
  }) : _searchKey = searchKey;

  final TextEditingController _searchKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          controller: _searchKey,
          decoration: InputDecoration(
            hintText: "Location",
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.location_on_outlined,
              color: Colors.grey[500],
              size: 18,
            ),
          ),
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
