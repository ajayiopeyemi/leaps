import 'package:flutter/widgets.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/enums/leaps_state_enums.dart';
import 'package:leaps/features/authentication/data/models/regions.dart';
import 'package:leaps/features/authentication/data/services/regions_service.dart';

import '../../../../core/base/leaps_base_model.dart';

class RegionViewModel extends LeapsBaseModel {
  RegionService _regionService;
  Stream<List<Regions>> regionStream;
  List<String> schools;
  List<String> classes;

  RegionViewModel({@required RegionService region}) : _regionService = region;

  Stream getCountries() {
    try {
      regionStream = _regionService.getCountries();
      return regionStream;
    } catch (error) {
      print(error);
      return regionStream;
    }
  }

  Future fetchSchools(country) async {
    try {
      setGetState(ViewStateGet.Loading);
      schools = await _regionService.fetchSchool(country);

      if (schools.length == 0) {
        setGetState(ViewStateGet.Empty);
        print('State is empty');
        return false;
      }

      if (schools.length >= 1) {
        setGetState(ViewStateGet.hasData);
        print('State is hasData');
        return false;
      }
      return true;
    } catch (error) {
      print('This error occured $error');
      setGetState(ViewStateGet.Error);
      throw Exception(error);
    }
  }

  Future fetchClasses(country) async {
    try {
      setGetState(ViewStateGet.Loading);
      classes = await _regionService.fetchClasses(country);

      if (classes.length == 0) {
        setGetState(ViewStateGet.Empty);
        print('State is empty');
        return false;
      }

      if (classes.length >= 1) {
        setGetState(ViewStateGet.hasData);
        print('State is hasData');
        return false;
      }
      return true;
    } catch (error) {
      print('This error occured $error');
      setGetState(ViewStateGet.Error);
      throw Exception(error);
    }
  }

  Future getClasses(String country) async{
    try {
      classInRegion = await _regionService.fetchClasses(country);
      return classInRegion;
    } catch (error) {
      print(error);
      throw Exception(error);
    }
  }
}
