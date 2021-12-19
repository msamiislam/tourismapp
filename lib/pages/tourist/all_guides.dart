import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tourismapp/models/enums.dart';
import 'package:tourismapp/models/guide_model.dart';
import 'package:tourismapp/models/user_model.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/utils/constants.dart';
import 'package:tourismapp/widgets/card.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class AllGuidesPage extends StatelessWidget {
  const AllGuidesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText("Guides")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: FutureBuilder<List<UserModel>>(
            future: Database.getUsers(UserType.guide),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<UserModel> users = snapshot.data!;
              return AllGuidesScaffold([...users.map((e) => e as GuideModel)]);
            }),
      ),
    );
  }
}

class AllGuidesScaffold extends StatefulWidget {
  final List<GuideModel> guides;

  const AllGuidesScaffold(this.guides, {Key? key}) : super(key: key);

  @override
  _AllGuidesScaffoldState createState() => _AllGuidesScaffoldState();
}

class _AllGuidesScaffoldState extends State<AllGuidesScaffold> {
  final GlobalKey<FormBuilderFieldState> _cityKey = GlobalKey<FormBuilderFieldState>();
  List<GuideModel> filteredGuides = [];

  @override
  void initState() {
    filteredGuides = [...widget.guides];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilderDropdown<String>(
          key: _cityKey,
          name: "city",
          isExpanded: true,
          allowClear: true,
          clearIcon: InkWell(
            onTap: () {
              _cityKey.currentState!.didChange(null);
              setState(() => filteredGuides = [...widget.guides]);
            },
            child: Icon(Icons.close),
          ),
          decoration: InputDecoration(
            hintText: "Select a city",
            labelText: "City",
            border: OutlineInputBorder(),
          ),
          onChanged: (newValue) {
            setState(() {
              filteredGuides = [...widget.guides.where((element) => element.city == newValue)];
            });
          },
          items: Constants.cityContacts.keys.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
        ),
        SizedBox(height: 20.0),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.65 / 2,
          ),
          shrinkWrap: true,
          itemCount: filteredGuides.length,
          itemBuilder: (context, index) => GuideCard(filteredGuides[index]),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
