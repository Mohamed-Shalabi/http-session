import 'package:flutter/material.dart';
import 'package:http_session/models/university_model.dart';
import 'package:http_session/server/api.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final universities = <UniversityModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Searcher'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 44,
            margin: const EdgeInsets.all(8),
            child: Form(
              key: formKey,
              child: TextFormField(
                validator: _validateSearchText,
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: _searchForUniversitiesByCountry,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: universities.isEmpty
                ? const Center(
                    child: Text(
                      'No results',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    children: [
                      ...universities.map(
                        (university) => Container(
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
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  String? _validateSearchText(String? value) {
    final valueString = value ?? '';
    if (valueString.isEmpty) {
      return 'Search text must not be empty';
    }
    return null;
  }

  void _searchForUniversitiesByCountry() async {
    final validated = formKey.currentState?.validate() ?? false;
    if (!validated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Search text must not be empty'),
        ),
      );
      return;
    }

    final result = await Api.searchForUniversitiesByCountry(
      searchController.text.trim(),
    );

    universities.clear();
    for (final universityMap in result) {
      final university = UniversityModel.fromMap(universityMap);
      universities.add(university);
    }

    setState(() {});
  }
}
