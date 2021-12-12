import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tourismapp/models/attraction_model.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/utils/progress_dialog.dart';
import 'package:tourismapp/widgets/card.dart';
import 'package:tourismapp/widgets/simple_txt.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<AttractionModel> attractions = [];
  List<AttractionModel> filteredAttractions = [];
  List<String> typeFilters = [];

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
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    onSubmitted: (query) {
                      search();
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Search",
                      border: OutlineInputBorder(),
                      suffixIcon: InkWell(
                        child: Icon(FontAwesomeIcons.search),
                        onTap: search,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () {
                    Get.dialog(
                      FilterDialog(
                        typeFilters,
                        onFilterApplied: (selectedFilters) {
                          typeFilters = selectedFilters;
                          applyFilter();
                        },
                      ),
                      barrierDismissible: true,
                    );
                  },
                  child: Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Icon(Icons.filter_alt, size: 28.0, color: AppColors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: filteredAttractions.isEmpty
                  ? Center(child: Lottie.asset('anim/search.json'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredAttractions.length,
                      itemBuilder: (context, index) => AttractionCard(filteredAttractions[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void search() async {
    if (_controller.text.isNotEmpty) {
      Loader.show(context, text: "Fetching...");
      attractions = await Database.searchAttractions(_controller.text.trim());
      applyFilter();
      Loader.hide();
    }
  }

  void applyFilter() {
    filteredAttractions.clear();
    if (typeFilters.isNotEmpty) {
      for (String filter in typeFilters) {
        filteredAttractions.addAll(attractions.where((element) => element.type == filter));
      }
    } else {
      filteredAttractions.addAll(attractions);
    }
    setState(() {});
  }
}

class FilterDialog extends StatefulWidget {
  final void Function(List<String> selectedTypes) onFilterApplied;
  final List<String> selectedFilters;

  const FilterDialog(this.selectedFilters, {Key? key, required this.onFilterApplied}) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  List<String> selectedFilters = [];

  @override
  void initState() {
    selectedFilters = widget.selectedFilters;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(child: Container(color: Colors.black26)),
        Positioned(
          width: Get.width * 0.7,
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(10.0),
            color: Get.theme.colorScheme.background,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.grey,
                  child: GridView.count(
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 1,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    children: AttractionType.values
                        .map((e) => PhysicalModel(
                              borderRadius: BorderRadius.circular(10.0),
                              color: selectedFilters.contains(e)
                                  ? Get.theme.colorScheme.primary
                                  : Get.theme.colorScheme.background,
                              child: InkWell(
                                onTap: () {
                                  if (selectedFilters.contains(e)) {
                                    selectedFilters.remove(e);
                                  } else {
                                    selectedFilters.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Center(
                                  child: AppText(
                                    e,
                                    color: selectedFilters.contains(e)
                                        ? Get.theme.colorScheme.background
                                        : Get.theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      widget.onFilterApplied.call(selectedFilters);
                      Get.back();
                    },
                    child: Text("Apply"))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
