import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapps/model/todo_model.dart';
import 'package:todoapps/provider/todo_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Apps"),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (context) => TodoProvider(),
          )
        ],
        child: SingleChildScrollView(
          child: HomeBody(),
        ),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoProv = Provider.of<TodoProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: TextField(
                    controller: nameController,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "What's are you doing?"
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      todoProv.addTodo(
                        TodoModel(name: nameController.text)
                      );
                      nameController.text = "";
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.blue,
                  child: Icon(Icons.send, color: Colors.white,),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TodoItem()
        ],
      )
    );
  }
}


class TodoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProv, child) {
        return Container(
          child: ListView.builder(
            itemCount: todoProv.getTodo.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, int index) {
              return Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      todoProv.getTodo[index].name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        todoProv.removeTodo(index);
                      },
                      child: Icon(Icons.remove_circle, color: Colors.blue, size: 30,)
                    )
                  ],
                )
              );
            },
          )
        );
      },
    );
  }
}