import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:work/login_page.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Schedule List'),
          actions: const [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/iconimage.jpg'),
            ),
            SizedBox(width: 16),
          ],
        ),
        drawer: Drawer(
          child: Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text("Sign out"),
            ),
          ),
        ),
        body: const TodoScreen(),
      ),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class TodoItem {
  String title;
  bool isCompleted;
  DateTime? dueDate;

  TodoItem({required this.title, this.isCompleted = false, this.dueDate});
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoItem> todoItems = [];
  TextEditingController textEditingController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: _onSelectNotification,
    );
  }

  Future<void> _onSelectNotification(String? payload) async {
    print('Notification selected: $payload');
  }

  Future<void> _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      // 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      sound: RawResourceAndroidNotificationSound(
          'notification_sound'), // Set the custom sound
    );

    //var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
    //sound: 'notification_sound.aiff', // Set the custom sound
    //);

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      //iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> _scheduleNotification(TodoItem todoItem) async {
    if (todoItem.dueDate != null) {
      var localTimeZone = tz.local;
      var scheduledNotificationDateTime = tz.TZDateTime.from(
        todoItem.dueDate!.subtract(const Duration(minutes: 5)),
        localTimeZone,
      );

      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        //'channel_description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        sound: RawResourceAndroidNotificationSound(
            'notification'), // Set the custom sound
      );

      //var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      //  sound: 'notification_sound.aiff', // Set the custom sound
      //);

      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        //   iOS: iOSPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Todo Due',
        'It\'s time to complete "${todoItem.title}"',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  void _addTodoItem() {
    if (textEditingController.text.isNotEmpty) {
      setState(() {
        todoItems.add(
          TodoItem(
            title: textEditingController.text,
            dueDate: selectedDate.add(Duration(
                hours: selectedTime.hour, minutes: selectedTime.minute)),
          ),
        );
        textEditingController.clear();

        _showNotification(
            'Todo Reminder', 'Time to complete "${todoItems.last.title}"');
        _scheduleNotification(
            todoItems.last); // Schedule notification for the new todo
      });
    }
  }

  void _deleteTodoItem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Row(
          //   children: [
          //     IconButton(
          //       onPressed: () {},
          //       icon: const Icon(Icons.menu),
          //     ),
          //     const CircleAvatar(
          //       radius: 20,
          //       backgroundImage: NetworkImage('assets/iconimage.jpg'),
          //     ),
          //   ],
          // ),
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[300],
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const Text('My Schedule:', style: TextStyle(fontSize: 18)),
          ListView.builder(
            shrinkWrap: true,
            itemCount: todoItems.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Checkbox(
                      value: todoItems[index].isCompleted,
                      onChanged: (value) {
                        setState(() {
                          todoItems[index].isCompleted = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(todoItems[index].title),
                          if (todoItems[index].dueDate != null)
                            Text(
                                'Due: ${DateFormat('MMM dd, yyyy HH:mm').format(todoItems[index].dueDate!)}'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _deleteTodoItem(index),
                      child: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Schedule',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: _addTodoItem,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select Date'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: const Text('Select Time'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
