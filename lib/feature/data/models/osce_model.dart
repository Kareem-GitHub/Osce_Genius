import 'dart:convert';
import 'package:equatable/equatable.dart';

class OsceModel extends Equatable {
  final List<String>? historicalIllnessQuestions;
  final List<String>? clinicalExaminationsToBePerformed;
  final List<String>? bedsideInvestigationsToBePerformed;
  final List<String>? initialLabInvestigations;
  final List<String>? anyAdditionalInvestigations;
  final List<String>? differentialDiagnosis;

  const OsceModel({
    this.historicalIllnessQuestions,
    this.clinicalExaminationsToBePerformed,
    this.bedsideInvestigationsToBePerformed,
    this.initialLabInvestigations,
    this.anyAdditionalInvestigations,
    this.differentialDiagnosis,
  });

  factory OsceModel.fromMap(Map<String, dynamic> data) => OsceModel(
        historicalIllnessQuestions:
            (data['historicalIllnessQuestions'] as List<dynamic>?)
                ?.map((item) => item as String)
                .toList(),
        clinicalExaminationsToBePerformed:
            (data['clinicalExaminationsToBePerformed'] as List<dynamic>?)
                ?.map((item) => item as String)
                .toList(),
        bedsideInvestigationsToBePerformed:
            (data['bedsideInvestigationsToBePerformed'] as List<dynamic>?)
                ?.map((item) => item as String)
                .toList(),
        initialLabInvestigations:
            (data['initialLabInvestigations'] as List<dynamic>?)
                ?.map((item) => item as String)
                .toList(),
        anyAdditionalInvestigations:
            (data['anyAdditionalInvestigations'] as List<dynamic>?)
                ?.map((item) => item as String)
                .toList(),
        differentialDiagnosis: (data['differentialDiagnosis'] as List<dynamic>?)
            ?.map((item) => item as String)
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'historicalIllnessQuestions': historicalIllnessQuestions,
        'clinicalExaminationsToBePerformed': clinicalExaminationsToBePerformed,
        'bedsideInvestigationsToBePerformed':
            bedsideInvestigationsToBePerformed,
        'initialLabInvestigations': initialLabInvestigations,
        'anyAdditionalInvestigations': anyAdditionalInvestigations,
        'differentialDiagnosis': differentialDiagnosis,
      };

  factory OsceModel.fromJson(String data) {
    return OsceModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  OsceModel copyWith({
    List<String>? historicalIllnessQuestions,
    List<String>? clinicalExaminationsToBePerformed,
    List<String>? bedsideInvestigationsToBePerformed,
    List<String>? initialLabInvestigations,
    List<String>? anyAdditionalInvestigations,
    List<String>? differentialDiagnosis,
  }) {
    return OsceModel(
      historicalIllnessQuestions:
          historicalIllnessQuestions ?? this.historicalIllnessQuestions,
      clinicalExaminationsToBePerformed: clinicalExaminationsToBePerformed ??
          this.clinicalExaminationsToBePerformed,
      bedsideInvestigationsToBePerformed: bedsideInvestigationsToBePerformed ??
          this.bedsideInvestigationsToBePerformed,
      initialLabInvestigations:
          initialLabInvestigations ?? this.initialLabInvestigations,
      anyAdditionalInvestigations:
          anyAdditionalInvestigations ?? this.anyAdditionalInvestigations,
      differentialDiagnosis:
          differentialDiagnosis ?? this.differentialDiagnosis,
    );
  }

  @override
  List<Object?> get props {
    return [
      historicalIllnessQuestions,
      clinicalExaminationsToBePerformed,
      bedsideInvestigationsToBePerformed,
      initialLabInvestigations,
      anyAdditionalInvestigations,
      differentialDiagnosis,
    ];
  }
}
