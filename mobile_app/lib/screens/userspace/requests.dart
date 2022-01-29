import 'package:chat_app/Firebase/firebaseFunction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Requests extends StatefulWidget {
  final dynamic users;
  final dynamic you;
  Requests({Key? key, this.users, this.you}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  dynamic requests = [];
  @override
  Widget build(BuildContext context) {
    widget.users.forEach((element) {
      if (widget.you.get('requestRecieved').contains(element.get('id'))) {
        requests.add(element);
      }
    });
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListTile(
              title: Center(
                child: Text(requests[index].get('user_ID')),
              ),
              subtitle: Center(
                child: Text(requests[index].get('name')),
              ),
              leading: Icon(
                Icons.account_circle_outlined,
                size: 60,
              ),
              trailing: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        Provider.of<FireBaseFunction>(context, listen: false)
                            .acceptRequest(
                                widget.you.get('requestAccepted'),
                                widget.you.get('requestRecieved'),
                                requests[index].get('requestAccepted'),
                                requests[index].get('requestSent'),
                                requests[index].get('id'),
                                widget.you.get('id'));
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(color: Colors.red)))),
                      child: Text('Accept')),
                      TextButton(
                      onPressed: () {
                        
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(color: Colors.red)))),
                      child: Text('Deny')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
