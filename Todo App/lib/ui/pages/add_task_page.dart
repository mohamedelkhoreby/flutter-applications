import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a')
      .format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int selectedColor = 0;

  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: primaryClr,
        ),
      ),
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 18,
        ),
        SizedBox(width: 20),
      ],
    );
  }
  validateDate(){
    if(titleController.text.isNotEmpty|| noteController.text.isNotEmpty){
      addTasksToDb();
      Get.back();
    }else if(titleController.text.isEmpty|| noteController.text.isEmpty){
      Get.snackbar(
          'required',
          'All fields are required!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: const Icon(Icons.warning_amber_rounded,color: Colors.red,)
      );
    }else{
       print('############ SOMETHING BAD HAPPENED #################');
    }
  }
  addTasksToDb() async {
    try {
      int value = await taskController.addTask(
        task: Task(
            title: titleController.text,
            note: noteController.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(selectedDate),
            startTime: startTime,
            endTime: endTime,
            color: selectedColor,
            remind: selectedRemind,
            repeat: selectedRepeat
        )
    );
     print('id value = $value');
    } catch (e) {
      print('Error = $e');
    }
  }
  Column colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
            children: List<Widget>.generate(
                3,
                    (index) => GestureDetector(
                  onTap: (() {
                    setState(() {
                      selectedColor = index;
                    });
                  }),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      backgroundColor: index == 0
                          ? primaryClr
                          : index == 1
                          ? pinkClr
                          : orangeClr,
                      radius: 14,
                      child: selectedColor == index
                          ? const Icon(Icons.done,
                          size: 16, color: Colors.white)
                          : null,
                    ),
                  ),
                )))
      ],
    );
  }
  getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    } else {
      if (kDebugMode) {
        print('It\'s null or something is wrong');
      }
    }
  }
  getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    String formattedTime = pickedTime!.format(context);
    if (isStartTime) {
      setState(() => startTime = formattedTime);
    } else if (!isStartTime) {
      setState(() => endTime = formattedTime);
    } else {
      if (kDebugMode) {
        print('time canceld or something is wrong');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appBar(),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Add Task', style: headingStyle),
                InputField(
                  tilte: 'Title',
                  hint: 'Enter Title',
                  controller: titleController,
                ),
                InputField(
                  tilte: 'note',
                  hint: 'Enter note',
                  controller: noteController,
                ),
                InputField(
                  tilte: 'Date',
                  hint: DateFormat.yMd().format(selectedDate),
                  widget: IconButton(
                    onPressed: () { FocusScope.of(context).unfocus();
                    getDateFromUser();},
                    icon: const Icon(Icons.calendar_today_outlined,
                        color: Colors.green),
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: InputField(
                      tilte: 'StartTime',
                      hint: startTime,
                      widget: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(Icons.access_time_rounded,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InputField(
                      tilte: 'endTime',
                      hint: endTime,
                      widget: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.access_time_filled_rounded,
                            color: Colors.green),
                      ),
                    ),
                  )
                ]),
                InputField(
                    tilte: 'Remind',
                    hint: '$selectedRemind minutes early',
                    widget: Row(
                      children: [
                        DropdownButton(
                          dropdownColor: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                          items: remindList
                              .map<DropdownMenuItem<String>>(
                                (int value) => DropdownMenuItem(
                              value: value.toString(),
                              child: Text(
                                '$value',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                              .toList(),
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey),
                          iconSize: 35,
                          elevation: 4,
                          underline: Container(height: 0),
                          style: subTitleStyle,
                          onChanged: (String? newvalue) {
                            setState(() {
                              selectedRemind = int.parse(newvalue!);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                    ),
                    ),
                InputField(
                  tilte: 'Repeat',
                  hint: selectedRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: repeatList
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                            .toList(),
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey),
                        iconSize: 35,
                        elevation: 4,
                        underline: Container(height: 0),
                        style: subTitleStyle,
                        onChanged: (String? newvalue) {
                          setState(() {
                            selectedRepeat = newvalue!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        colorPalette(),
                        MyButton(
                            label: 'Creat Task',
                            onTap: () {
                              validateDate();
                            })
                      ],
                    ),
                const SizedBox(height: 8),
              ]
            ),
          ),
          ),
    );
  }
}
