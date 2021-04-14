import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/repository/list_item_repository.dart';

class NewItem extends StatefulWidget {
  final ListsModel listDetail;

  NewItem({Key key, @required this.listDetail}) : super(key: key);

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  TextEditingController _titleField = TextEditingController();
  TextEditingController _budgetField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListItemRepository>(context);

    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 40, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add Item",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
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
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 40)),
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  await listProvider.addItem(widget.listDetail.id,
                      _titleField.text, false, _budgetField.text);
                  Navigator.pop(context);
                } else {
                  print('not valid');
                  return null;
                }
              },
              child: Text(
                "Continue",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
