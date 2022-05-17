import 'package:cat_breed/utils/constants.dart';
import 'package:cat_breed/view/cat_information_card.dart';
import 'package:cat_breed/widgets/size_container.dart';
import 'package:flutter/material.dart';
import 'package:cat_breed/model/cat_model.dart';
import 'package:cat_breed/viewmodel/cats_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'not_available.dart';

Widget catListView(CatsViewModel catsViewModel, context) {
  return ListView.separated(
      itemBuilder: (context, index) {
        Cat cat = catsViewModel.catListModel[index];
        bool isURLValid = (cat.images != null)
            ? cat.images?.url != null
                ? Uri.parse(cat.images!.url.toString()).host.isNotEmpty
                : false
            : false;
        return GestureDetector(
          onTap: () {
            //print(cat.name.toString());
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.1, end: 1).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutQuart,
                      ),
                    ),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return CatInformation(
                    name: cat.name.toString(),
                    description: cat.description.toString(),
                    image: isURLValid ? cat.images!.url.toString() : 'null',
                    adaptability: cat.adaptability.toString(),
                    intelligence: cat.intelligence.toString(),
                    energy_level: cat.energyLevel.toString(),
                    affection_level: cat.affectionLevel.toString(),
                  );
                },
              ),
            );
          },
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      cat.name.toString(),
                      style: Constants.appTitle,
                    ),
                    isURLValid
                        ? sizedContainer(
                            CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                imageUrl: cat.images!.url.toString(),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    notAvailable()),
                          )
                        : sizedContainer(CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: Constants.noDisponible,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                notAvailable())),
                    _footerInfo(
                        cat.origin.toString(), cat.intelligence.toString())
                  ]),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Container(
            height: 10,
          ),
      itemCount: catsViewModel.catListModel.length);
}

Widget _footerInfo(String origin, String intelligence) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        children: [
          const Text(
            "Origin country: ",
            style: Constants.titles,
          ),
          Text(origin, style: Constants.subTitles),
        ],
      ),
      Column(
        children: [
          const Text("Intelligence: ", style: Constants.titles),
          Text(intelligence, style: Constants.subTitles),
        ],
      )
    ],
  );
}
