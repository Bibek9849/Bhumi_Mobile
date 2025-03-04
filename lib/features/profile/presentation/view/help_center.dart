import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  final List<Map<String, String>> faqs = [
    {
      "question": "How to sell my products?",
      "answer": "Go to the 'Sell' section and list your products."
    },
    {
      "question": "How to track my order?",
      "answer": "Go to 'Orders' and select the order to track."
    },
    {
      "question": "How can I contact customer support?",
      "answer":
          "You can email us at support@bhumimarket.com or call 1800-123-456."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search for help...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // FAQ Section
            Expanded(
              child: ListView.builder(
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(faqs[index]["question"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(faqs[index]["answer"]!),
                      )
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Contact and Support Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.email, color: Colors.green),
                  onPressed: () {}, // Open Email Support
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.green),
                  onPressed: () {}, // Open Phone Support
                ),
                IconButton(
                  icon: const Icon(Icons.chat, color: Colors.green),
                  onPressed: () {}, // Open Chat Support
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Request Help Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: const Text("Request Help"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
