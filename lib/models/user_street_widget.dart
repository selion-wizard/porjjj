import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStreetWidget extends StatefulWidget {
  const UserStreetWidget({super.key});

  @override
  _UserStreetWidgetState createState() => _UserStreetWidgetState();
}

class _UserStreetWidgetState extends State<UserStreetWidget> {
  String _userStreet = 'Улица не указана';

  @override
  void initState() {
    super.initState();
    _loadUserStreet();
  }

  Future<void> _loadUserStreet() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userStreet = prefs.getString('user_street') ?? 'Улица не указана';
    });
  }

  void _editStreet() async {
    final prefs = await SharedPreferences.getInstance();
    final TextEditingController streetController = TextEditingController(
      text: _userStreet == 'Улица не указана' ? '' : _userStreet
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Изменить улицу'),
        content: TextField(
          controller: streetController,
          decoration: const InputDecoration(
            hintText: 'Введите улицу',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () async {
              final trimmedStreet = streetController.text.trim();
              if (trimmedStreet.isNotEmpty) {
                await prefs.setString('user_street', trimmedStreet);
                setState(() {
                  _userStreet = trimmedStreet;
                });
                Navigator.pop(context);
              } else {
                // Показываем снекбар, если улица пустая
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Пожалуйста, введите название улицы'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _editStreet,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Ваша улица: $_userStreet',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.edit, color: Colors.blue, size: 20),
          ],
        ),
      ),
    );
  }
}