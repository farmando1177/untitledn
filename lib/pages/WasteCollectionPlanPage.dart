import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WasteCollectionPlanPage extends StatefulWidget {
  @override
  _WasteCollectionPlanPageState createState() => _WasteCollectionPlanPageState();
}

class _WasteCollectionPlanPageState extends State<WasteCollectionPlanPage> {
  List<Map<String, dynamic>> schedule = [
    {"day": "Sunday", "area": "Downtown", "time": "08:00 AM", "icon": Icons.location_city},
    {"day": "Monday", "area": "Uptown", "time": "09:30 AM", "icon": Icons.apartment},
    {"day": "Tuesday", "area": "Suburbs", "time": "10:00 AM", "icon": Icons.house},
    {"day": "Wednesday", "area": "West Side", "time": "11:00 AM", "icon": Icons.business},
    {"day": "Thursday", "area": "East Side", "time": "07:30 AM", "icon": Icons.location_on},
  ];

  String selectedDay = DateFormat('EEEE').format(DateTime.now());
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Ensure the selectedDay is always in the list
    if (!schedule.any((entry) => entry['day'] == selectedDay)) {
      selectedDay = schedule[0]['day'];
    }

    List<Map<String, dynamic>> filteredSchedule = schedule
        .where((entry) =>
        entry['area'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Waste Collection Plan"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by area...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedDay,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: schedule.map<DropdownMenuItem<String>>((entry) {
                return DropdownMenuItem<String>(
                  value: entry['day'],
                  child: Text(entry['day']!),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSchedule.length,
              itemBuilder: (context, index) {
                bool isToday = filteredSchedule[index]['day'] == selectedDay;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isToday ? Colors.green[100] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 5),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      filteredSchedule[index]['area'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${filteredSchedule[index]['day']} - ${filteredSchedule[index]['time']}"),
                    leading: Icon(
                      filteredSchedule[index]['icon'],
                      color: isToday ? Colors.green : Colors.grey,
                    ),
                    trailing: isToday ? Icon(Icons.check_circle, color: Colors.green) : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}