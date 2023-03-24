class CongViec {
  final String work;
  final DateTime deadline;
  bool done;

  CongViec({
    required this.work,
    required this.deadline,
    this.done = false,
  });
}
