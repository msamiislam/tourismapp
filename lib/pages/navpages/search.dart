import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/card.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    controller: _controller,
                    name: "search",
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(isDense: true, hintText: "Search", border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  child: Icon(Icons.filter_alt, size: 28.0, color: AppColors.white),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) => PlaceCard(),
              ),
            ),
            // Expanded(
            //   child: Center(child: Lottie.asset('anim/search.json')),
            // ),
          ],
        ),
      ),
    );
  }
}