import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  String _selectedCategory = 'General';
  Map<String, List<String>> _faqData = {
    'General': [
      'What is WeCare?',
      'How to use WeCare?',
      'Can I create my own fundraising?',
    ],
    'Login': [
      'How to top up balance on WeCare?',
      'How to withdraw balance on WeCare?',
    ],
    'Account': [
      'Is there a free tips to use this app',
      'Is WeCare free to use?',
    ],
    'Wecare': [
      'How to make offer on WeCare?',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: Color(0xFF13B156)),
        ),
        title: const Text('FAQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Buttons (Scrollable)
            SizedBox(
              height: 35, // Adjust height as needed
              child: ListView(
                scrollDirection: Axis.horizontal, // Make it horizontal
                children: [
                  for (int i = 0; i < _faqData.keys.length; i++)
                    Row(
                      children: [
                        if (i > 0)
                          SizedBox(
                            width: 16, // Add spacing between buttons
                          ),
                        CategoryButton(
                          title: _faqData.keys.elementAt(i),
                          isSelected: _selectedCategory ==
                              _faqData.keys.elementAt(i),
                          onPressed: () {
                            setState(() {
                              _selectedCategory =
                                  _faqData.keys.elementAt(i);
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),

            // Scrollable FAQ List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String question in _faqData[_selectedCategory]!)
                      FAQItem(
                        question: question,
                        answer: '...', // Add your answer here
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function() onPressed;

  const CategoryButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Color(0xFF13B156) // Green background when selected
            : Colors.white, // White background when not selected
        foregroundColor: isSelected
            ? Colors.white // White text when selected
            : Color(0xFF13B156), // Green text when not selected
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        textStyle: const TextStyle(
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isSelected
              ? BorderSide.none // No border when selected
              : BorderSide(
                  color: Color(0xFF13B156), // Green border when not selected
                  width: 2,
                ),
        ),
      ),
      child: Text(title),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(widget.question),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.answer),
          ),
        ],
        trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
      ),
    );
  }
}