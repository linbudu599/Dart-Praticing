import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

/*
  FIXME:
  似乎和React的思路不太一样
  这里我想在全局启动应用前初始化App(runApp, 因为建立连接是异步的, 不能在组件initState里跑)
  然后把操作数据库的方法传下去给应用 应用在onTap中调用对应的CRUD方法
  (涉及到StatefulWidget传参, 大致思路理解了, 在createState里做)
  但是在应用中 打印出来actions是有方法的 却无法调用?

  已解决:
  Dart中估计是.和['']的属性寻找方式不太一样?
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    },
    version: 1,
  );

  Future<void> insertDog(Dog dog) async {
    final Database db = await database;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> findDogs() async {
    final Database db = await database;
    final List<Map<String, dynamic>> resultMaps = await db.query("dogs");

    return List.generate(
        resultMaps.length,
        (i) => Dog(
              id: resultMaps[i]['id'],
              name: resultMaps[i]['name'],
              age: resultMaps[i]['age'],
            ));
  }

  Future<void> updateDog(Dog dog) async {
    final db = await database;
    await db.update(
      'dogs',
      dog.toMap(),
      where: "id = ?",
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    final db = await database;
    await db.delete(
      'dogs',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  runApp(DataPersistenceDemo(actions: {
    "insert": insertDog,
    "find": findDogs,
    "update": updateDog,
    "delete": deleteDog,
  }));
}

class DataPersistenceDemo extends StatefulWidget {
  final dynamic actions;

  DataPersistenceDemo({Key key, @required this.actions}) : super(key: key);

  @override
  // _DataPersistenceDemoState createState() => _DataPersistenceDemoState(actions);
  _DataPersistenceDemoState createState() => _DataPersistenceDemoState();
}

class _DataPersistenceDemoState extends State<DataPersistenceDemo> {
  Map<String, dynamic> actions;
  List<Dog> local_dogs;

  Dog fido = Dog(
    id: 0,
    name: 'Fido',
    age: 3,
  );

  // _DataPersistenceDemoState(actions) {
  //   this.actions = actions;
  // }

// 透了原来这样就行
  @override
  void initState() {
    super.initState();
    (widget.actions['insert'](fido) as Future<void>).then((_val) {
      widget.actions['find']().then((val) {
        print(val);
      });
    });
  }

  Future<List<Dog>> query() async {
    return await this.actions['find']();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'DB Demo',
        theme: ThemeData(
          fontFamily: "FiraCode",
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text("Database Demo")),
          body: Center(
              child: Column(
            children: <Widget>[
              Container(height: 300, width: 300, child: Text("")),
              RaisedButton(
                  onPressed: () async {
                    await this.actions['insert'](fido);
                    print(await query());
                  },
                  child: Text("Insert Dog")),
              RaisedButton(
                  onPressed: () async {
                    print(await query());
                  },
                  child: Text("Find Dog")),
              RaisedButton(
                  onPressed: () async {
                    await this.actions['update'](Dog(
                      id: fido.id,
                      name: fido.name,
                      age: fido.age + 7,
                    ));
                    print(await query());
                  },
                  child: Text("Update Dog")),
              RaisedButton(
                  onPressed: () async {
                    await this.actions['delete'](0);
                    print(await query());
                  },
                  child: Text("Delete Dog"))
            ],
          )),
        ));
  }
}
