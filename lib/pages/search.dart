import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FormBuilderTextField(
            name: "search",
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(isDense: true, hintText: "Search", border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}
