import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Goal {
  final String title;
  final bool isDone;
  final DateTime dateUploaded;

  Goal({required this.title, this.isDone = false, required this.dateUploaded});

  Goal toggleStatus() {
    return Goal(title: title, isDone: !isDone, dateUploaded: dateUploaded);
  }
}

class GoalDisplay extends StatefulWidget {
  const GoalDisplay({Key? key}) : super(key: key);

  @override
  _GoalDisplayState createState() => _GoalDisplayState();
}

class _GoalDisplayState extends State<GoalDisplay> {
  final List<Goal> _goals = [];

  void _addGoal(String title, String description, String deadline) {
    setState(() {
      _goals.add(Goal(title: title, dateUploaded: DateTime.now()));
    });
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
    DateTime? selectedDeadline;


  void _showAddGoalDialog() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add New Goal'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter goal title',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter goal description',
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now().add(const Duration(days: 1)), // Future only
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  selectedDeadline = pickedDate;
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedDeadline != null
                      ? 'Deadline: ${selectedDeadline!.toLocal().toIso8601String().split('T')[0]}'
                      : 'Tap to select goal deadline',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleController.text.isNotEmpty && selectedDeadline != null) {
              _addGoal(
                titleController.text,
                descriptionController.text,
                selectedDeadline!.toIso8601String(),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
 
  }

  String _daysAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    return '${diff.inDays} day(s) ago';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _showAddGoalDialog,
          icon: const Icon(Icons.add),
          label: const Text('Add My Goal'),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: _goals.isEmpty
              ? const Center(child: Text('No goals added yet.'))
              : ListView.builder(
                  itemCount: _goals.length,
                  itemBuilder: (context, index) {
                    final goal = _goals[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        title: Text(goal.title),
                        subtitle: Text(
                          'Status: ${goal.isDone ? 'Done' : 'Not Done'}\n'
                          'Uploaded: ${DateFormat.yMMMd().format(goal.dateUploaded)} - ${_daysAgo(goal.dateUploaded)}',
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            goal.isDone
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: goal.isDone ? Colors.green : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _goals[index] = goal.toggleStatus();
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
