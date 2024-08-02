import 'package:flutter/material.dart';
import 'package:internshala/features/internships/domain/entity/internship_entity.dart';

class InternshipCard extends StatelessWidget {
  final InternshipEntity internship;

  const InternshipCard({
    super.key,
    required this.internship,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            internship.isActive
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6)),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Actively hiring',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 10),
            Text(
              internship.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              internship.companyName,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 5),
                for (var intern in internship.locationNames)
                  Text("$intern, ",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black)),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.calendar_today, size: 12),
                SizedBox(width: 5),
                Text('Starts Immediately',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
              ],
            ),
            const SizedBox(height: 10),
            if (internship.duration.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.access_time, size: 12),
                  const SizedBox(width: 5),
                  Text(internship.duration,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black)),
                ],
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.money_sharp, size: 12),
                const SizedBox(width: 5),
                Text(internship.salary ?? "0",
                    style: const TextStyle(fontSize: 12, color: Colors.black)),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey.shade300,
              ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Internship",
                    style: TextStyle(fontSize: 12, color: Colors.black)),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey.shade300,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(internship.postedByLabel,
                    style: const TextStyle(fontSize: 12, color: Colors.black)),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Implement view details functionality
                },
                child: const Text(
                  'View details',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
