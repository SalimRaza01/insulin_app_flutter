import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:tuple/tuple.dart';

class SLIDERSCREEN extends StatefulWidget {
  const SLIDERSCREEN({super.key});

  @override
  State<SLIDERSCREEN> createState() => _SLIDERSCREENState();
}

class _SLIDERSCREENState extends State<SLIDERSCREEN> {
  WeightType weightType = WeightType.kg;

  double weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$weight ${weightType.name}'),
            Container(
              height: 300,
              child: Expanded(
                child: DivisionSlider(
                  from: 0,
                  max: 100,
                  initialValue: weight,
                  type: weightType,
                  onChanged: (value) => setState(() => weight = value),
                  title: "Weight",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) async {
    final res = await showModalBottomSheet<Tuple2<WeightType, double>>(
      context: context,
      elevation: 0,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: _bottomSheetDecoration,
            height: 250,
            child: Column(
              children: [
                _Header(
                  weightType: weightType,
                  inKg: weight,
                ),
                _Switcher(
                  weightType: weightType,
                  onChanged: (type) => setState(() => weightType = type),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: DivisionSlider(
                    from: 0,
                    max: 100,
                    initialValue: weight,
                    type: weightType,
                    onChanged: (value) => setState(() => weight = value),
                    title: "Weight",
                  ),
                )
              ],
            ),
          );
        });
      },
    );
    if (res != null) {
      setState(() {
        weightType = res.item1;
        weight = res.item2;
      });
    }
  }
}

const _bottomSheetDecoration = BoxDecoration(
  color: Color(0xffD9D9D9),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  ),
);

class _Header extends StatelessWidget {
  const _Header({
    required this.weightType,
    required this.inKg,
  });

  final WeightType weightType;
  final double inKg;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Colors.black54,
            onPressed: () => navigator.pop(),
            icon: const Icon(Icons.close),
          ),
          const Text('Weight',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          IconButton(
            color: Colors.black54,
            onPressed: () => navigator.pop<Tuple2<WeightType, double>>(
              Tuple2(weightType, inKg),
            ),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}

enum WeightType {
  kg,
    cms,
  years,
}

extension WeightTypeExtension on WeightType {
  String get name {
    switch (this) {
      case WeightType.kg:
        return 'kg';
      case WeightType.cms:
        return 'cms';
            case WeightType.years:
        return 'Years';
    }
  }
}

class _Switcher extends StatelessWidget {
  final WeightType weightType;
  final ValueChanged<WeightType> onChanged;
  const _Switcher({
    Key? key,
    required this.weightType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            top: 2,
            width: 121,
            height: 36,
            left: weightType == WeightType.kg ? 2 : 127,
            duration: const Duration(milliseconds: 300),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildButton(WeightType.kg),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildButton(WeightType type) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(type),
        child: Center(
          child: Text(
            type.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class DivisionSlider extends StatefulWidget {
  final double from;
  final double max;
  final double initialValue;
  final Function(double) onChanged;
   WeightType? type;
   
  final String title;

   DivisionSlider({
    required this.from,
    required this.max,
    required this.initialValue,
    required this.onChanged,
     this.type,
    required this.title,
    super.key,
  });

  @override
  State<DivisionSlider> createState() => _DivisionSliderState();
}

class _DivisionSliderState extends State<DivisionSlider> {
  PageController? numbersController;
  final itemsExtension = 1000;
  late double value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  void _updateValue() {
    value = ((((numbersController?.page ?? 0) - itemsExtension) * 10)
                .roundToDouble() /
            10)
        .clamp(widget.from, widget.max);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.initialValue >= widget.from &&
        widget.initialValue <= widget.max);
    return Container(
      
      child: LayoutBuilder(
        builder: (context, constraints) {
          final viewPortFraction = 1 / (constraints.maxWidth / 10);
          numbersController = PageController(
            initialPage: itemsExtension + widget.initialValue.toInt(),
            viewportFraction: viewPortFraction * 10,
          );
          numbersController?.addListener(_updateValue);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Text(
                '$value ${widget.type?.name}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: greenColor,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 10,
                width: 11.5,
                child: CustomPaint(
                  painter: TrianglePainter(),
                ),
              ),
              _Numbers(
                itemsExtension: itemsExtension,
                controller: numbersController,
                start: widget.from.toInt(),
                end: widget.max.toInt(),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    numbersController?.removeListener(_updateValue);
    numbersController?.dispose();
    super.dispose();
  }
}

class TrianglePainter extends CustomPainter {
  TrianglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = greenColor;
    Paint paint2 = Paint()
      ..color = greenColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
    canvas.drawPath(line(size.width, size.height), paint2);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..lineTo(x, 0)
      ..lineTo(x / 2, y)
      ..lineTo(0, 0);
  }

  Path line(double x, double y) {
    return Path()
      ..moveTo(x / 2, 0)
      ..lineTo(x / 2, y * 2);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return true;
  }
}

const greenColor = Colors.grey;

class _Numbers extends StatelessWidget {
  final PageController? controller;
  final int itemsExtension;
  final int start;
  final int end;

  const _Numbers({
    required this.controller,
    required this.itemsExtension,
    required this.start,
    required this.end,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: PageView.builder(
        pageSnapping: false,
        controller: controller,
        physics: _CustomPageScrollPhysics(
          start: itemsExtension + start.toDouble(),
          end: itemsExtension + end.toDouble(),
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, rawIndex) {
          final index = rawIndex - itemsExtension;
          return _Item(index: index >= start && index <= end ? index : null);
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final int? index;

  const _Item({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const _Dividers(),
          if (index != null)
            Expanded(
              child: Center(
                child: Text(
                  '$index',
                  style:  TextStyle(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Dividers extends StatelessWidget {
  const _Dividers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(10, (index) {
          final thickness = index == 5 ? 1.5 : 0.5;
          return Expanded(
            child: Row(
              children: [
                Transform.translate(
                  offset: Offset(-thickness / 2, 0),
                  child: VerticalDivider(
                    thickness: thickness,
                    width: 1,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _CustomPageScrollPhysics extends ScrollPhysics {
  final double start;
  final double end;

  const _CustomPageScrollPhysics({
    required this.start,
    required this.end,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  _CustomPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _CustomPageScrollPhysics(
      parent: buildParent(ancestor),
      start: start,
      end: end,
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final oldPosition = position.pixels;
    final frictionSimulation =
        FrictionSimulation(0.4, position.pixels, velocity * 0.2);

    double newPosition = (frictionSimulation.finalX / 10).round() * 10;

    final endPosition = end * 10 * 10;
    final startPosition = start * 10 * 10;
    if (newPosition > endPosition) {
      newPosition = endPosition;
    } else if (newPosition < startPosition) {
      newPosition = startPosition;
    }
    if (oldPosition == newPosition) {
      return null;
    }
    return ScrollSpringSimulation(
      spring,
      position.pixels,
      newPosition.toDouble(),
      velocity,
      tolerance: tolerance,
    );
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 20,
        stiffness: 100,
        damping: 0.8,
      );
}
