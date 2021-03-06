import 'package:flutter/material.dart';
import '../assets/style/style.dart';

class SearchForm extends StatefulWidget {
  final void Function(String value) onChanged;

  const SearchForm({Key key, this.onChanged}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final searchKey = GlobalKey<FormState>();
  String query;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: searchKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: buttonColor, width: 5.0)),
                filled: true
            ),
            onChanged: (value) {
              query = value;
              final isValid = searchKey.currentState.validate();

              if(isValid) {
                widget.onChanged(query);
              } else {
                searchKey.currentState.deactivate();
              }
            },
          ),
        ],
      ),
    );
  }
}
