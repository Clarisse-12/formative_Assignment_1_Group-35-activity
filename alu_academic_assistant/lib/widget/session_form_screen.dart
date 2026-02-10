import 'package:flutter/material.dart';
import '../models/session.dart';
import '../logic/schedule_logic.dart';

class SessionFormScreen extends StatefulWidget {
  final Session? sessionToEdit;

  const SessionFormScreen({super.key, this.sessionToEdit});

  @override
  State<SessionFormScreen> createState() => _SessionFormScreenState();
}

class _SessionFormScreenState extends State<SessionFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _locationController;

  DateTime? _selectedDate;
  String? _startTime;
  String? _endTime;
  String? _sessionType;

  final List<String> _sessionTypes = [
    'Class',
    'Mastery Session',
    'Study Group',
    'PSL Meeting',
  ];

  @override
  void initState() {
    super.initState();

    final s = widget.sessionToEdit;

    _titleController = TextEditingController(text: s?.title ?? '');
    _locationController = TextEditingController(text: s?.location ?? '');
    _selectedDate = s?.date;
    _startTime = s?.startTime;
    _endTime = s?.endTime;
    _sessionType = s?.sessionType;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final time =
            picked.format(context); 
        isStart ? _startTime = time : _endTime = time;
      });
    }
  }

  void _save() {
    final errors = validateSession(
      title: _titleController.text,
      date: _selectedDate,
      startTime: _startTime,
      endTime: _endTime,
      sessionType: _sessionType,
    );

    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errors.values.first)),
      );
      return;
    }

    final session = Session(
      title: _titleController.text,
      date: _selectedDate!,
      startTime: _startTime!,
      endTime: _endTime!,
      location:
          _locationController.text.isEmpty ? null : _locationController.text,
      sessionType: _sessionType!,
    );

    Navigator.pop(context, session);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A3A),
      appBar: AppBar(
        title: Text(
          widget.sessionToEdit == null
              ? 'Add Session'
              : 'Edit Session',
        ),
        backgroundColor: const Color(0xFF0A1A3A),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _darkField(
                controller: _titleController,
                label: 'Session Title',
              ),

              const SizedBox(height: 12),

              _pickerButton(
                label: _selectedDate == null
                    ? 'Select Date'
                    : _selectedDate!.toLocal().toString().split(' ')[0],
                onTap: _pickDate,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _pickerButton(
                      label: _startTime ?? 'Start Time',
                      onTap: () => _pickTime(true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _pickerButton(
                      label: _endTime ?? 'End Time',
                      onTap: () => _pickTime(false),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              _darkField(
                controller: _locationController,
                label: 'Location (optional)',
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF122B5A),
                value: _sessionType,
                items: _sessionTypes
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(type,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _sessionType = value),
                decoration: _inputDecoration('Session Type'),
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _save,
                child: const Text(
                  'Save Session',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pickerButton({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF122B5A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _darkField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: const Color(0xFF122B5A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
