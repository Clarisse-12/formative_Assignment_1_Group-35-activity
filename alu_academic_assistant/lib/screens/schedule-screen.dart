import 'package:flutter/material.dart';
import '../logic/schedule_logic.dart';
import '../models/session.dart';
import '../widget/session_form_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final sessions = getWeeklySessions(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF0A1A3A),
      appBar: AppBar(
        title: const Text(
          'Weekly Schedule',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0A1A3A),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          final newSession = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SessionFormScreen()),
          );
          if (newSession != null) {
            setState(() => addSession(newSession));
          }
        },
      ),
      body: sessions.isEmpty
          ? const Center(
              child: Text(
                'No sessions scheduled',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];

                return Card(
                  color: const Color(0xFF122B5A),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.school, color: Colors.amber),
                    title: Text(
                      session.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${session.startTime} - ${session.endTime}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              session.sessionType,
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: session.isPresent,
                          activeColor: Colors.amber,
                          checkColor: Colors.black,
                          onChanged: (_) {
                            setState(() => toggleAttendance(session));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SessionFormScreen(
                                  sessionToEdit: session,
                                ),
                              ),
                            );
                            if (updated != null) {
                              setState(() => editSession(index, updated));
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            setState(() => deleteSession(index));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
