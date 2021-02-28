import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/utils/firebase_util.dart';
import 'package:leaps/features/search/data/models/resource.dart';

import '../../../../core/utils/leaps_user_details_util.dart';

class ResourceService extends FirebaseUtil {
  var client = http.Client();

  Future<List<Resource>> getResponse(
      String endpoint, String subject, String query) async {
    final resources = List<Resource>();
    var queryParameter = {
      ResourceConstants.SUBJECT: subject,
      ResourceConstants.QUERY: query
    };

    var uri = Uri.https(ApiConstants.baseUrl,
        '${ApiConstants.rootEndpoint}/$endpoint', queryParameter);
    print('Creatd Url: $uri');

    final response = await client.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${AppState.userDetails.country}'
    });
    print(response.body);

    final jsonResponse = json.decode(response.body) as List<dynamic>;
    for (var resource in jsonResponse) {
      resources.add(Resource.map(resource));
    }
    return resources
        .where((filter) => filter.isPending != true)
        .where((countryFilter) => countryFilter.country == AppState.userDetails.country)
        .toList();
  }

  Stream<List<Resource>> getWeek1Resources(
      String docId, String collection) async* {
    yield* FirebaseUtil.lessonPlans
        .document(docId)
        .collection(collection)
        .where('week', isEqualTo: 'Week 1')
        .snapshots()
        .map((list) =>
            list.documents.map((doc) => Resource.fromSnapshot(doc)).toList());
  }

  Stream<List<Resource>> getWeek2Resources(
      String docId, String collection) async* {
    yield* FirebaseUtil.lessonPlans
        .document(docId)
        .collection(collection)
        .where('week', isEqualTo: 'Week 2')
        .snapshots()
        .map((list) =>
            list.documents.map((doc) => Resource.fromSnapshot(doc)).toList());
  }
}
