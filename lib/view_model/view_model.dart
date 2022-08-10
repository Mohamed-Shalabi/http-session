import 'package:flutter/material.dart';
import 'package:http_session/models/university_model.dart';
import 'package:http_session/server/api.dart';
import 'package:http_session/utils/utils.dart';

class ViewModel with ChangeNotifier {
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final universities = <UniversityModel>[];

  bool get isValidated => formKey.currentState?.validate() ?? false;

  String? validateSearchText(String? value) {
    final valueString = value ?? '';
    if (valueString.isEmpty) {
      return 'Search text must not be empty';
    }
    return null;
  }

  void searchForUniversitiesByCountry() async {
    final result = await Api.searchForUniversitiesByCountry(
      searchController.text.trim(),
    );

    universities.clear();
    for (final universityMap in result) {
      final university = UniversityModel.fromMap(universityMap);
      universities.add(university);
    }

    notifyListeners();
  }
}
