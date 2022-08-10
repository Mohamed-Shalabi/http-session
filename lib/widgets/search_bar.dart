import 'package:flutter/material.dart';
import 'package:http_session/utils/utils.dart';
import 'package:http_session/view_model/view_model.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ViewModel>(context);

    return Container(
      width: double.infinity,
      height: 44,
      margin: const EdgeInsets.all(8),
      child: Form(
        key: viewModel.formKey,
        child: TextFormField(
          validator: viewModel.validateSearchText,
          controller: viewModel.searchController,
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
              onPressed: () async {
                if (!await Utils.isConnected()) {
                  showConnectionSnackBar(context);

                  return;
                }

                final isValidated = viewModel.isValidated;

                if (!isValidated) {
                  showValidationSnackBar(context);

                  return;
                }

                viewModel.searchForUniversitiesByCountry();
              },
            ),
          ),
        ),
      ),
    );
  }

  void showValidationSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Search text must not be empty'),
      ),
    );
  }

  void showConnectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('check your internet connection'),
      ),
    );
  }
}
