import 'package:flutter/material.dart';
import '../models/church.dart';
import '../localization/custom_localizations.dart';

class ChurchesPage extends StatefulWidget {
  const ChurchesPage({super.key});

  @override
  _ChurchesPageState createState() => _ChurchesPageState();
}

class _ChurchesPageState extends State<ChurchesPage> {
  // قائمة الكنائس الكاملة
  final List<Church> _allChurches = [
    Church(name: 'كنيسة مار مرقس', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص يوحنا'),
    Church(name: 'كنيسة مار مينا', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص بيمن بطرس'),
    Church(name: 'كنيسة مار مرقس', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص يوحنا'),
    Church(name: 'كنيسة مار مينا', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص بيمن بطرس'),
    Church(name: 'كنيسة مار مرقس', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص يوحنا'),
    Church(name: 'كنيسة مار مينا', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص بيمن بطرس'),
    Church(name: 'كنيسة مار مرقس', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص يوحنا'),
    Church(name: 'كنيسة مار مينا', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص بيمن بطرس'),
    Church(name: 'كنيسة مار مرقس', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص يوحنا'),
    Church(name: 'كنيسة مار مينا', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص بيمن بطرس'),
    Church(name: 'كنيسة مار مرقس', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص يوحنا'),
    Church(name: 'كنيسة مار مينا', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص بيمن بطرس'),
    Church(name: 'كنيسة مار مرقس', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص يوحنا'),
    Church(name: 'كنيسة مار مينا', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص بيمن بطرس'),
    Church(name: 'كنيسة مار مرقس', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص يوحنا'),
    Church(name: 'كنيسة مار مينا', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص بيمن بطرس'),
    Church(name: 'كنيسة مار مرقس', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص يوحنا'),
    Church(name: 'كنيسة مار مينا', info: 'معلومات عن الكنيسة', congregation: '', priests: 'القمص بيمن بطرس'),
    ];

  // قائمة الكنائس المعروضة
  List<Church> _displayedChurches = [];

  @override
  void initState() {
    super.initState();
    _displayedChurches = _allChurches;
  }

  // تصفية الكنائس بناءً على نص البحث
  void _filterChurches(String query) {
    setState(() {
      _displayedChurches = _allChurches.where((church) {
        return church.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = CustomLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('كنيستي')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // صندوق البحث
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: localization.translate('search'),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterChurches,
            ),
          ),
          // قائمة الكنائس
          Expanded(
            child: ListView.builder(
              itemCount: _displayedChurches.length,
              itemBuilder: (context, index) {
                final church = _displayedChurches[index];
                return Card(
                  child: ListTile(
                    title: Text(church.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(church.info),
                        Text(localization.translate('congregation') + church.congregation),
                        Text(localization.translate('priests') + church.priests),
                      ],
                    ),
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