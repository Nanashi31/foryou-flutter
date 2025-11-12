import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({super.key});

  @override
  _NewRequestScreenState createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  int _currentStep = 0;

  // Data to be passed between steps
  String? _projectType;
  final Map<String, bool> _availableDays = {
    'Lunes': false, 'Martes': false, 'Miércoles': false, 'Jueves': false,
    'Viernes': false, 'Sábado': false, 'Domingo': false,
  };

  void _nextPage() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _DetailsStep(
          onNext: _nextPage,
          onProjectTypeChanged: (value) => setState(() => _projectType = value),
        );
      case 1:
        return _ScheduleStep(
          onNext: _nextPage,
          onBack: _previousPage,
          availableDays: _availableDays,
        );
      case 2:
        return _ReviewStep(
          onBack: _previousPage,
          projectType: _projectType,
          availableDays: _availableDays,
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F2FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Nueva Solicitud',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildStepper(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildCurrentStep(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Container(
      key: ValueKey<int>(_currentStep),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStep(index: 0, label: 'Detalles'),
          _buildStep(index: 1, label: 'Agendar Cita'),
          _buildStep(index: 2, label: 'Revisar'),
        ],
      ),
    );
  }

  Widget _buildStep({required int index, required String label}) {
    final bool isActive = _currentStep >= index;
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isActive
                ? const LinearGradient(
                    colors: [Color(0xFF8A2BE2), Color(0xFF6A0DAD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isActive ? null : Colors.grey[200],
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: isActive ? const Color(0xFF6A0DAD) : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _DetailsStep extends StatefulWidget {
  final VoidCallback onNext;
  final ValueChanged<String> onProjectTypeChanged;
  const _DetailsStep({required this.onNext, required this.onProjectTypeChanged});

  @override
  __DetailsStepState createState() => __DetailsStepState();
}

class __DetailsStepState extends State<_DetailsStep> {
  String? _selectedProjectType;
  final List<String> _projectTypes = [
    'Rejas para ventanas', 'Portones', 'Escaleras', 'Barandales',
    'Puertas', 'Estructuras metálicas', 'Reparaciones', 'Otro'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detalles y Especificaciones', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Cuéntanos qué necesitas y las especificaciones', style: GoogleFonts.poppins(color: Colors.grey)),
            const SizedBox(height: 24),
            _buildDropdown(
              label: 'Tipo de proyecto',
              hint: 'Selecciona el tipo de trabajo',
              value: _selectedProjectType,
              items: _projectTypes,
              onChanged: (value) {
                setState(() {
                  _selectedProjectType = value;
                });
                widget.onProjectTypeChanged(value!);
              },
            ),
            _buildTextField(label: 'Descripción del proyecto', hint: 'Describe detalladamente lo que necesitas...', maxLines: 3),
            _buildTextField(label: 'Ubicación', hint: 'Ciudad, estado', icon: Icons.location_on_outlined),
            const SizedBox(height: 16),
            Text('Especificaciones', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildTextField(label: 'Medidas aproximadas', hint: 'Ej: 2m x 1.5m'),
            _buildDropdown(label: 'Preferencia de materiales', hint: 'Selecciona el material', items: ['Acero', 'Hierro Forjado', 'Aluminio']),
            const SizedBox(height: 16),
            Text('Fotos del área (opcional)', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload_outlined, color: Colors.grey[400], size: 40),
                    Text('Toca para subir fotos del área', style: GoogleFonts.poppins(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildNextButton(onPressed: widget.onNext),
          ],
        ),
      ),
    );
  }
}

class _ScheduleStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final Map<String, bool> availableDays;

  const _ScheduleStep({required this.onNext, required this.onBack, required this.availableDays});

  @override
  __ScheduleStepState createState() => __ScheduleStepState();
}

class __ScheduleStepState extends State<_ScheduleStep> {
  @override
Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
           boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Agendar Cita', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Selecciona tu disponibilidad y fecha preferida', style: GoogleFonts.poppins(color: Colors.grey)),
            const SizedBox(height: 24),
            Text('Días disponibles para la cita', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.availableDays.keys.map((String key) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 70,
                  child: CheckboxListTile(
                    title: Text(key, style: GoogleFonts.poppins()),
                    value: widget.availableDays[key],
                    onChanged: (bool? value) {
                      setState(() {
                        widget.availableDays[key] = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text('Fecha preferida para la cita', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: const Color(0xFF8A2BE2).withOpacity(0.5), shape: BoxShape.circle),
                selectedDecoration: const BoxDecoration(color: Color(0xFF8A2BE2), shape: BoxShape.circle),
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(label: 'Referencias de ubicación', hint: 'Ej: Casa azul con portón blanco...', maxLines: 3),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildBackButton(onPressed: widget.onBack)),
                const SizedBox(width: 16),
                Expanded(child: _buildNextButton(onPressed: widget.onNext)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewStep extends StatelessWidget {
  final VoidCallback onBack;
  final String? projectType;
  final Map<String, bool> availableDays;

  const _ReviewStep({required this.onBack, this.projectType, required this.availableDays});

  @override
  Widget build(BuildContext context) {
    final selectedDays = availableDays.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .join(', ');

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
           boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Confirmación', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Revisa y envía tu solicitud', style: GoogleFonts.poppins(color: Colors.grey)),
            const SizedBox(height: 24),
            Text('Resumen de tu solicitud', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildReviewItem('Tipo de proyecto:', projectType ?? 'No especificado'),
            _buildReviewItem('Descripción:', 'No especificada'),
            _buildReviewItem('Ubicación:', 'No especificada'),
            _buildReviewItem('Medidas:', 'No especificadas'),
            _buildReviewItem('Material:', 'No especificado'),
            _buildReviewItem('Días disponibles:', selectedDays.isNotEmpty ? selectedDays : 'No especificados'),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF8A2BE2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Tu solicitud será enviada a herreros verificados en tu área. Recibirás cotizaciones en las próximas 24-48 horas.',
                style: GoogleFonts.poppins(color: const Color(0xFF6A0DAD)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildBackButton(onPressed: onBack)),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEC407A), Color(0xFF8A2BE2)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Submit logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Enviar solicitud', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widgets

Widget _buildTextField({required String label, required String hint, int maxLines = 1, IconData? icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      ],
    ),
  );
}

Widget _buildDropdown({required String label, required String hint, String? value, required List<String> items, ValueChanged<String?>? onChanged}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildReviewItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600])),
        Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF6A0DAD))),
      ],
    ),
  );
}

Widget _buildNextButton({required VoidCallback onPressed}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: const LinearGradient(
        colors: [Color(0xFF8A2BE2), Color(0xFF6A0DAD)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text('Siguiente', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}

Widget _buildBackButton({required VoidCallback onPressed}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: Colors.grey[300]!),
    ),
    child: Text('Anterior', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
  );
}