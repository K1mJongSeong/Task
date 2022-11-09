import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widget/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime  _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Task',style: headingStyle,),
              MyInputField(title: "Title", hint: "Enter your title"),
              MyInputField(title: "Note", hint: "Enter your note"),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: Icon(Icons.calendar_today_outlined,
                    color: Colors.grey,),
                      onPressed: (){
                        print("JongSeong");
                        _getDateFromUser();
                      },
                  )),
              Row(
                children: [
                Expanded(
                    child: MyInputField(
                  title: "Start Date",
                  hint: _startTime,
                  widget: IconButton(
                    onPressed: (){
_getTimeFromUser(isStartTime: true);
                    },
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey,
                    ),
                  ),
                )),
                  SizedBox(width: 12,),
                  Expanded(
                      child: MyInputField(
                        title: "End Date",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      )),
              ],),
              MyInputField(title: "Remind", hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                color: Colors.grey),
                iconSize: 32,
                elevation: 4,
                style: subHeadingStyle,
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                underline: Container(height: 0,),
                items: remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }
                ).toList(),
              ),
              ),
              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey),
                  iconSize: 32,
                  elevation: 4,
                  style: subHeadingStyle,
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  underline: Container(height: 0,),
                  items: repeatList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!,style: TextStyle(color: Colors.grey)),
                    );
                  }
                  ).toList(),
                ),
              ),
              SizedBox(height: 18,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color",
                      style: titleStyle,
                      ),
                      SizedBox(height: 8.0,),
                      Wrap(
                        children: List<Widget>.generate(
                            3,
                                (int index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _selectedColor=index;
                                    print("$index");
                                  });
                                },
                                child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                                radius: 14,
                            backgroundColor: index==0?primaryClr:index==1?pinkClr:yellowClr,
                            child: _selectedColor==index?Icon(Icons.done,color: Colors.white,size: 16,):Container(),
                          ),
                        ),
                              );
                        }
                        )
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white:Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
              "images/profile.png"
          ),
        ),
        SizedBox(width: 20,)
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2015), lastDate: DateTime(2027));

    if(_pickerDate!=null){
      setState((){
          _selectedDate = _pickerDate;
          print(_selectedDate);
      });
    }else{
      print("잠시 후 다시 시도해주세요.");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("Time cancel");
    }else if(isStartTime==true){
      setState(() {
        _startTime=_formatedTime;
      });
    }else if(isStartTime==false){
      setState(() {
        _endTime=_formatedTime;
      });
    }
  }

  _showTimePicker(){
    return showTimePicker(context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
    ));
  }
}
