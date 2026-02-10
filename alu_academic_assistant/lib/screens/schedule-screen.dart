// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// This screen is a placeholder for the Schedule screen. It displays the current date in a formatted way. You can expand it with actual scheduling functionality later.
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});
// build: Displays the current date in a formatted way using the `intl` package. The date is shown below the "Schedule" title. You can expand this screen later to include actual scheduling functionality, such as a calendar view or a list of upcoming events.
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMM d, yyyy').format(now);
// The UI consists of a centered column with the title "Schedule" and the current date displayed below it. The date is formatted to show the day of the week, month, day, and year for better readability.
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Schedule',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          Text(
            'Today: $formattedDate',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}