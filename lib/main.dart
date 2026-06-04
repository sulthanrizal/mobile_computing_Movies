import 'package:flutter/material.dart';
import 'movie.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eksplorasi Widget Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MoviesCatalog(),
    );
  }
}

// ─── Halaman Utama ─────────────────────────────────────────────────────────────

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final combinations = [
//       _CombinationInfo(
//         number: '01',
//         title: 'Text & RichText',
//         subtitle: 'Text · RichText · TextSpan · TextStyle',
//         icon: Icons.text_fields,
//         color: Colors.indigo,
//         page: const TextWidgetsPage(),
//       ),
//       _CombinationInfo(
//         number: '02',
//         title: 'Layout Row & Column',
//         subtitle: 'Row · Column · Expanded · Flexible · SizedBox',
//         icon: Icons.view_column,
//         color: Colors.teal,
//         page: const LayoutWidgetsPage(),
//       ),
//       _CombinationInfo(
//         number: '03',
//         title: 'Scrolling & List',
//         subtitle: 'ListView · ListTile · Divider · Scrollbar',
//         icon: Icons.list,
//         color: Colors.orange,
//         page: const ScrollingWidgetsPage(),
//       ),
//       _CombinationInfo(
//         number: '04',
//         title: 'Card & Stack',
//         subtitle: 'Card · Stack · Positioned · ClipRRect · Badge',
//         icon: Icons.layers,
//         color: Colors.purple,
//         page: const CardStackPage(),
//       ),
//       _CombinationInfo(
//         number: '05',
//         title: 'Grid & Wrap',
//         subtitle: 'GridView · Wrap · Chip · Container · Icon',
//         icon: Icons.grid_view,
//         color: Colors.red,
//         page: const GridWrapPage(),
//       ),
//     ];

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         title: const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Eksplorasi Widget Flutter',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '5 Kombinasi Widget Unik',
//               style: TextStyle(fontSize: 12, color: Colors.white70),
//             ),
//           ],
//         ),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: combinations.length,
//         itemBuilder: (context, index) {
//           final item = combinations[index];
//           return _CombinationCard(info: item);
//         },
//       ),
//     );
//   }
// }

class _CombinationInfo {
  final String number;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget page;

  const _CombinationInfo({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.page,
  });
}

class _CombinationCard extends StatelessWidget {
  final _CombinationInfo info;
  const _CombinationCard({required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => info.page),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'lib/img1.jpeg',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kombinasi ${info.number}',
                      style: TextStyle(
                        fontSize: 11,
                        color: info.color,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      info.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      info.subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Kombinasi 01: Text & RichText ─────────────────────────────────────────────

class TextWidgetsPage extends StatelessWidget {
  const TextWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kombinasi 01: Text & RichText'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionLabel('Widget: Text', Colors.indigo),
            const SizedBox(height: 12),

            // Text biasa
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Teks Biasa',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ini adalah contoh teks dengan overflow ellipsis yang sangat panjang '
                      'dan akan terpotong jika melebihi batas yang telah ditentukan.'
                      'Ini adalah contoh teks dengan overflow ellipsis yang sangat panjang '
                      'dan KWKWKWKKWKWKWKakan terpotong jika melebihi batas yang telah ditentukan.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'HURUF KAPITAL DENGAN LETTER SPACING',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            sectionLabel('Widget: RichText + TextSpan', Colors.indigo),
            const SizedBox(height: 12),

            // RichText dengan TextSpan
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        children: [
                          TextSpan(text: 'Flutter '),
                          TextSpan(
                            text: 'adalah',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(text: ' framework '),
                          TextSpan(
                            text: 'UI lintas platform',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' dari '),
                          TextSpan(
                            text: 'Google.',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: '★ ',
                            style: TextStyle(color: Colors.amber, fontSize: 20),
                          ),
                          TextSpan(
                            text: 'Widget',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: [Colors.indigo, Colors.purple],
                                ).createShader(
                                  const Rect.fromLTWH(0, 0, 200, 0),
                                ),
                            ),
                          ),
                          const TextSpan(
                            text: ' adalah blok pembangun UI',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          const TextSpan(
                            text: ' ★',
                            style: TextStyle(color: Colors.amber, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            sectionLabel('Widget: SelectableText', Colors.indigo),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  'Teks ini bisa dipilih dan disalin!\n'
                  'Coba tekan dan tahan untuk memilih teks.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.indigo[800],
                    height: 1.6,
                  ),
                  showCursor: true,
                  cursorColor: Colors.indigo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Kombinasi 02: Layout Row & Column ────────────────────────────────────────

class LayoutWidgetsPage extends StatelessWidget {
  const LayoutWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kombinasi 02: Layout'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionLabel('Widget: Row + Expanded + Flexible', Colors.teal),
            const SizedBox(height: 12),

            // Row dengan Expanded
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Row + Expanded (flex berbeda)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.teal[200],
                            child: const Center(child: Text('flex:1')),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            color: Colors.teal[400],
                            child: const Center(
                              child: Text(
                                'flex:2',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 50,
                            color: Colors.teal[700],
                            child: const Center(
                              child: Text(
                                'flex:3',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            sectionLabel('Widget: Column + MainAxisAlignment', Colors.teal),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'MainAxisAlignment: spaceBetween',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 120,
                      color: Colors.teal[50],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _colorBox('Atas', Colors.teal[300]!),
                          _colorBox('Tengah', Colors.teal[500]!),
                          _colorBox('Bawah', Colors.teal[700]!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            sectionLabel('Widget: Container + Padding + Align', Colors.teal),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Rata Kiri',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal[600],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Rata Tengah',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Rata Kanan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            sectionLabel('Widget: Wrap (beda dari Row!)', Colors.teal),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Dart',
                    'Flutter',
                    'Widget',
                    'StatelessWidget',
                    'StatefulWidget',
                    'BuildContext',
                    'MaterialApp',
                    'Scaffold',
                  ]
                      .map(
                        (label) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            border: Border.all(color: Colors.teal),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: Colors.teal[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _colorBox(String label, Color color) {
  return Container(
    width: double.infinity,
    height: 30,
    color: color,
    child: Center(
      child: Text(label, style: const TextStyle(color: Colors.white)),
    ),
  );
}

// ─── Kombinasi 03: Scrolling & List ───────────────────────────────────────────

class ScrollingWidgetsPage extends StatefulWidget {
  const ScrollingWidgetsPage({super.key});

  @override
  State<ScrollingWidgetsPage> createState() => _ScrollingWidgetsPageState();
}

class _ScrollingWidgetsPageState extends State<ScrollingWidgetsPage> {
  final List<Map<String, dynamic>> _items = List.generate(
    12,
    (i) => {
      'title': 'Item Flutter #${i + 1}',
      'subtitle': 'Contoh ListTile ke-${i + 1} dalam ListView',
      'icon': Icons.widgets,
      'color': Colors.primaries[i % Colors.primaries.length],
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kombinasi 03: Scrolling & List'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Header horizontal scrolling
          Container(
            color: Colors.orange[50],
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 8),
                  child: Text(
                    'SingleChildScrollView (Horizontal)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      'Basics',
                      'Layout',
                      'Scrolling',
                      'Text',
                      'Input',
                      'Animation',
                      'Interaction',
                    ]
                        .map(
                          (label) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Label
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Icon(Icons.list, size: 18, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'ListView + ListTile + Divider',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // Scrollbar + ListView
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _items.length,
                separatorBuilder: (_, _) =>
                    const Divider(indent: 72, height: 1),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: (item['color'] as Color).withValues(alpha: 0.2),
                      child: Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(item['subtitle'] as String),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Kombinasi 04: Card & Stack ───────────────────────────────────────────────

class CardStackPage extends StatelessWidget {
  const CardStackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kombinasi 04: Card & Stack'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionLabel('Widget: Stack + Positioned', Colors.purple),
            const SizedBox(height: 12),

            // Profile Card dengan Stack
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Background gradient
                    Container(
                      height: 180,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.purple, Colors.deepPurple],
                        ),
                      ),
                    ),
                    // Decorative circles
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      left: -10,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                    // Content
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundImage: AssetImage('lib/img1.jpeg'),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Mahasiswa Flutter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Teknik Informatika · 2024',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Badge di pojok kanan atas
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'AKTIF',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            sectionLabel('Widget: Card + Row + Icon + Text', Colors.purple),
            const SizedBox(height: 12),

            // Stats cards
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Widget',
                    value: '5',
                    icon: Icons.widgets,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    label: 'Kombinasi',
                    value: '5',
                    icon: Icons.layers,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    label: 'Halaman',
                    value: '5',
                    icon: Icons.pages,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            sectionLabel('Widget: Stack (overlap)', Colors.purple),
            const SizedBox(height: 12),

            // Stacked overlapping avatars
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Avatar yang Tumpang Tindih (Stack):',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      child: Stack(
                        children: List.generate(5, (i) {
                          final colors = [
                            Colors.purple,
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                            Colors.red,
                          ];
                          return Positioned(
                            left: i * 34.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: colors[i],
                                child: Text(
                                  '${i + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'lib/img1.jpeg',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Kombinasi 05: Grid & Wrap ────────────────────────────────────────────────

class GridWrapPage extends StatefulWidget {
  const GridWrapPage({super.key});

  @override
  State<GridWrapPage> createState() => _GridWrapPageState();
}

class _GridWrapPageState extends State<GridWrapPage> {
  final List<String> _selectedChips = [];

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Basics', 'icon': Icons.star, 'color': Colors.red},
    {'label': 'Layout', 'icon': Icons.view_quilt, 'color': Colors.blue},
    {'label': 'Text', 'icon': Icons.text_fields, 'color': Colors.green},
    {'label': 'Input', 'icon': Icons.input, 'color': Colors.orange},
    {'label': 'Scrolling', 'icon': Icons.swap_vert, 'color': Colors.purple},
    {'label': 'Animation', 'icon': Icons.animation, 'color': Colors.teal},
    {'label': 'Material', 'icon': Icons.layers, 'color': Colors.indigo},
    {'label': 'Cupertino', 'icon': Icons.phone_iphone, 'color': Colors.grey},
  ];

  final List<Map<String, dynamic>> _gridItems = [
    {'icon': Icons.widgets, 'label': 'Widgets', 'color': Colors.red},
    {'icon': Icons.palette, 'label': 'Theme', 'color': Colors.pink},
    {'icon': Icons.navigation, 'label': 'Navigate', 'color': Colors.purple},
    {'icon': Icons.storage, 'label': 'State', 'color': Colors.indigo},
    {'icon': Icons.animation, 'label': 'Animate', 'color': Colors.blue},
    {'icon': Icons.http, 'label': 'Network', 'color': Colors.cyan},
    {'icon': Icons.folder, 'label': 'Files', 'color': Colors.teal},
    {'icon': Icons.notifications, 'label': 'Notif', 'color': Colors.green},
    {'icon': Icons.camera, 'label': 'Camera', 'color': Colors.lime},
    {'icon': Icons.location_on, 'label': 'Location', 'color': Colors.yellow},
    {'icon': Icons.bluetooth, 'label': 'BLE', 'color': Colors.orange},
    {'icon': Icons.settings, 'label': 'Settings', 'color': Colors.brown},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kombinasi 05: Grid & Wrap'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionLabel('Widget: Wrap + FilterChip', Colors.red),
            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pilih Kategori Widget:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: _categories.map((cat) {
                        final label = cat['label'] as String;
                        final isSelected = _selectedChips.contains(label);
                        return FilterChip(
                          avatar: Icon(
                            cat['icon'] as IconData,
                            size: 16,
                            color: isSelected
                                ? Colors.white
                                : cat['color'] as Color,
                          ),
                          label: Text(label),
                          selected: isSelected,
                          selectedColor: cat['color'] as Color,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          onSelected: (val) {
                            setState(() {
                              if (val) {
                                _selectedChips.add(label);
                              } else {
                                _selectedChips.remove(label);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    if (_selectedChips.isNotEmpty) ...[
                      const Divider(),
                      Text(
                        'Dipilih: ${_selectedChips.join(', ')}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            sectionLabel(
              'Widget: GridView.count (2 kolom)',
              Colors.red,
            ),
            const SizedBox(height: 8),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: _gridItems.map((item) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'lib/img1.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['label'] as String,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),
            sectionLabel('Widget: GridView.builder (responsif)', Colors.red),
            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.0,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: (cat['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (cat['color'] as Color).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cat['icon'] as IconData,
                            color: cat['color'] as Color,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            cat['label'] as String,
                            style: TextStyle(
                              color: cat['color'] as Color,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Helper Widgets ────────────────────────────────────────────────────────────

Widget sectionLabel(String text, Color color) {
  return Row(
    children: [
      Container(width: 4, height: 18, color: color),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}
