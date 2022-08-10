import 'package:flutter/material.dart';
import 'package:http_session/models/university_model.dart';
import 'package:http_session/server/api.dart';
import 'package:http_session/utils/utils.dart';
import 'package:http_session/view_model/view_model.dart';
import 'package:http_session/widgets/search_bar.dart';
import 'package:http_session/widgets/universities_grid_view.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Searcher'),
      ),
      body: ChangeNotifierProvider<ViewModel>(
        create: (context) => ViewModel(),
        builder: (BuildContext context, _) {
          final viewModel = Provider.of<ViewModel>(context);

          return Column(
            children: [
              const SearchBar(),
              Expanded(
                child: viewModel.universities.isEmpty
                    ? const NoResultsWidget()
                    : const UniversitiesGridView(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No results',
        style: TextStyle(
          color: Colors.red,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
