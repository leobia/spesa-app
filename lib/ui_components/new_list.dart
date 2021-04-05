import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/viewmodels/ItemListCRUDModel.dart';

class NewList extends StatefulWidget {
  @override
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  TextEditingController _titleField = TextEditingController();
  TextEditingController _budgetField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ItemListCRUDModel>(context);

    return Container(
      child: Column(
        children: [
          Container(
            height: 70,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "NUOVA LISTA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await listProvider.addList(
                        _titleField.text,
                        _budgetField.text,
                      );
                      Navigator.pop(context);
                    } else {
                      print('not valid');
                      return null;
                    }
                  },
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: ListView(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please fill";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: _titleField,
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _budgetField,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.euro),
                        labelText: "Budget",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
