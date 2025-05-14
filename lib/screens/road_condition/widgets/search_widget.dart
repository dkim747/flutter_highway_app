import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {

  final ValueChanged<String> search;
  final TextEditingController controller;

  const SearchWidget({
    super.key,
    required this.search,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: '노선명(노선번호) 또는 IC/JC명으로 검색',
          suffixIcon: Icon(Icons.search_rounded)
        ),
        onChanged: (value) {
          search(value);
        },

      ),
    );
  }
}
