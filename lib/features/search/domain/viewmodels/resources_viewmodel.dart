import 'package:flutter/widgets.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:leaps/features/search/data/services/resource_service.dart';

import '../../../../core/base/leaps_base_model.dart';
import '../../../../core/enums/leaps_state_enums.dart';

class ResourcesViewModel extends LeapsBaseModel {
  ResourceService _resourceService;
  List<Resource> resources;

  ResourcesViewModel({@required ResourceService resourceServices})
      : _resourceService = resourceServices;

  Future getResources(
      String endpoint, String selectedSubject, String queryText) async {
    try {
      setGetState(ViewStateGet.Loading);
      resources = await _resourceService.getResponse(
          endpoint, selectedSubject, queryText);

      if (resources.length == 0) {
        setGetState(ViewStateGet.Empty);
        print('State is empty');
        return false;
      }

      if (resources.length >= 1) {
        setGetState(ViewStateGet.hasData);
        print('State is hasData');
        notifyListeners();
        return false;
      }
      return true;
    } catch (error) {
      print('This error occured $error');
      setGetState(ViewStateGet.Error);
      return false;
    }
  }

  ///[getWeekOneNotePlans] from the [LessonPlanCollection] of [sub]-[collection]
  ///where each document that has the value[Week1] with key[week] only will be [Queried]
  ///To be used in the [NoteScreen] for both [Teachers] & [Students]
  Stream getResourcesInWeek1(String docId, String collection) {
    Stream<List<Resource>> resourceStream;
    try {
      resourceStream = _resourceService.getWeek1Resources(docId, collection);
      return resourceStream;
    } catch (error) {
      print('This error occure: $error');
      return resourceStream;
    }
  }

  ///[getWeekOneNotePlans] from the [LessonPlanCollection] of [sub]-[collection]
  ///where each document that has the value[Week2] with key[week] only will be [Queried]
  ///To be used in the [NoteScreen] for both [Teachers] & [Students]
  Stream getResourcesInWeek2(String docId, String collection) {
    Stream<List<Resource>> resourceStream;
    try {
      resourceStream = _resourceService.getWeek2Resources(docId, collection);
      return resourceStream;
    } catch (error) {
      print('This error occure: $error');
      return resourceStream;
    }
  }
}
