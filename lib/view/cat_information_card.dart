import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_breed/model/cat_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../viewmodel/cats_view_model.dart';
import '../widgets/not_available.dart';
import '../widgets/size_container.dart';

class CatInformation extends StatelessWidget {
  String name,
      description,
      image,
      intelligence,
      adaptability,
      energy_level,
      affection_level;
  CatInformation(
      {Key? key,
      required this.name,
      required this.description,
      required this.image,
      required this.adaptability,
      required this.intelligence,
      required this.energy_level,
      required this.affection_level})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> lista = [
      Text(description, style: Constants.subTitles),
      Text('Adaptability: ' + adaptability),
      Text('Inteligence: ' + intelligence),
      Text('Energy level: ' + energy_level),
      Text('Afectivity ' + affection_level)
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
              child: Column(
            children: [
              Expanded(flex: 1, child: Text(name, style: Constants.appTitle)),
              (image != 'null')
                  ? Expanded(
                      flex: 3,
                      child: sizedContainer(CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          imageUrl: image,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              notAvailable())))
                  : Expanded(
                      flex: 2,
                      child: sizedContainer(CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: Constants.noDisponible,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              notAvailable()))),
              Expanded(
                flex: 3,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Card(
                          child: ListTile(
                            title: lista[index],
                          ),
                        ),
                    itemCount: lista.length,
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        )),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
