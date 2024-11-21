import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SkillSelectionScreen(),
    );
  }
}

class SkillSelectionScreen extends StatefulWidget {
  @override
  _SkillSelectionScreenState createState() => _SkillSelectionScreenState();
}

class _SkillSelectionScreenState extends State<SkillSelectionScreen> {
  // Data model for skills grouped by category
  Map<String, List<String>> skillCategories = {
    'Technology': [
      'HR Technology Specialist',
      'Product Manager',
      'Application Engineer',
      'IT Delivery Manager',
    ],
    'Data & Analytics': [
      'Data Analyst',
      'Data Governance Lead',
      'Data Management Analyst',
      'Data Visualization'
    ],
    'Sales': [
      'Sales Consultant',
      'Lead Generation Manager',
      'Internal Sales Consultant'
    ],
    'Marketing': [
      'Marketing Specialist',
      'Editor',
      'Creative Technology Leader'
    ]
  };

  // Store whether each skill is selected
  Map<String, Map<String, bool>> selectedSkills = {};

  // Initialize selectedSkills map
  @override
  void initState() {
    super.initState();
    // Initialize the selectedSkills map for each category
    skillCategories.forEach((category, skills) {
      selectedSkills[category] = {for (var skill in skills) skill: false};
    });
  }

  // Toggle skill selection
  void toggleSkillSelection(String category, String skill) {
    setState(() {
      selectedSkills[category]![skill] = !selectedSkills[category]![skill]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Skills')),
      body: ListView(
        children: skillCategories.keys.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category header
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              // List of skills under the category
              Column(
                children: skillCategories[category]!
                    .map((skill) => CheckboxListTile(
                  title: Text(skill),
                  value: selectedSkills[category]![skill],
                  onChanged: (bool? selected) {
                    toggleSkillSelection(category, skill);
                  },
                ))
                    .toList(),
              ),
            ],
          );
        }).toList(),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // Collect selected skills
          Map<String, List<String>> selectedSkillsMap = {};
          selectedSkills.forEach((category, skills) {
            selectedSkillsMap[category] = skills.keys
                .where((skill) => skills[skill] == true)
                .toList();
          });

          print("Selected Skills: $selectedSkillsMap");
        },
        child: Text('Save Skills'),
      ),
    );
  }
}
