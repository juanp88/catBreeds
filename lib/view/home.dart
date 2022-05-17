import 'package:cat_breed/utils/constants.dart';
import 'package:cat_breed/viewmodel/cats_view_model.dart';
import 'package:cat_breed/widgets/listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchInput = '';

  @override
  Widget build(BuildContext context) {
    TextEditingController _mycontroller = TextEditingController();
    final catsList = Provider.of<CatsViewModel>(context, listen: true);
    _mycontroller.text = searchInput;

    return SafeArea(
        child: Scaffold(
            backgroundColor: Constants.backgroundColor,
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(40.0),
                  child: const Text(
                    'Cat Breeds',
                    style: Constants.appTitle,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        controller: _mycontroller,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "Input the race you want to search",
                        ),
                        onSubmitted: (value) {
                          catsList.setBreed(value);
                          setState(() {
                            searchInput = value;
                          });
                          // print(value);
                          // setState(() {
                          //   searchInput = value;
                          // });
                        },
                      ),
                    )),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: SizedBox(
                      width: 350,
                      child: catListView(catsList, context),
                    ),
                  ),
                )
              ],
            )));
  }
}
