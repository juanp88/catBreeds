import 'package:cat_breed/service/cat_service.dart';
import 'package:cat_breed/utils/api_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum LoadMoreStatus { LOADING, STABLE }

class CatsViewModel extends ChangeNotifier {
  var _catListModel = [];
  String _searchBreed = '';

  get catListModel {
    if (searchBreed != '') {
      var filteredList = _catListModel.where((cat) {
        final nameLower = cat.name.toString().toLowerCase();
        final searchInput = searchBreed.toString().toLowerCase();
        return nameLower.contains(searchInput);
      }).toList();
      return filteredList;
    } else {
      return _catListModel;
    }
  }

  get searchBreed => _searchBreed;

  setBreed(searchBreed) {
    _searchBreed = searchBreed;
    notifyListeners();
  }

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  setCatListModel(catListModel) {
    _catListModel = catListModel;
    notifyListeners();
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  CatsViewModel() {
    getCats();
  }

  void getCats() async {
    var response = await CatService.getCats();
    if (response is Success) {
      if (catListModel.length == 0) {
        var list = response.response;
        setCatListModel(list);
      } else {
        setLoadingState(LoadMoreStatus.LOADING);
        // notifyListeners();
      }
    }
  }
}
