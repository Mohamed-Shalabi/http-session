import 'package:flutter/material.dart';
import 'package:http_session/models/university_model.dart';
import 'package:http_session/view_model/view_model.dart';
import 'package:provider/provider.dart';

class UniversitiesGridView extends StatelessWidget {
  const UniversitiesGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ViewModel>(context);

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      children: [
        ...viewModel.universities.map(
          (university) => UniversityTile(university: university),
        ),
      ],
    );
  }
}

class UniversityTile extends StatelessWidget {
  const UniversityTile({Key? key, required this.university}) : super(key: key);

  final UniversityModel university;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            university.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          ...university.webPages.map(
            (e) => Text(e),
          ),
        ],
      ),
    );
  }
}
