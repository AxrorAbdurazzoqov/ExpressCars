import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileState extends Equatable {
  final ProfileStatus status;
  final List docsInfo = [
    {
      'title': 'License',
      'icon': Icons.wallet
    },
    {
      'title': 'Passport',
      'icon': Icons.wallet_sharp
    },
    {
      'title': 'Contract',
      'icon': Icons.document_scanner
    },
  ];

  final List profileActions = [
    {
      'title': 'Edit Profile',
      'icon': Icons.person,
    },
    {
      'title': 'My bookings',
      'icon': Icons.document_scanner,
    },
    {
      'title': 'Logout',
      'icon': Icons.logout,
    }
  ];
  ProfileState({required this.status});

  @override
  List<Object> get props => [];
}

enum ProfileStatus {
  initial,
  loading,
  success,
  failure
}
