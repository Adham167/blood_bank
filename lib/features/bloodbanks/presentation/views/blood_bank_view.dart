import 'package:blood_bank/features/bloodbanks/presentation/manager/getBloodBankcubit/getbloodbank_cubit.dart';
import 'package:blood_bank/features/bloodbanks/presentation/widgets/blood_bank_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BloodBankView extends StatelessWidget {
  const BloodBankView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetBloodBankCubit()..getBloodBanks(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xfffafafa),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Nearby Blood Bank",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BlocBuilder<GetBloodBankCubit, GetBloodBankState>(
            builder: (context, state) {
              int banksCount = 0;

              if (state is GetBloodBankSuccess) {
                banksCount = state.bloodBanks.length;
              }

              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("$banksCount Blood banks Found"),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        if (state is GetBloodBankFailure) {
                          return Center(child: Text(state.errMessages));
                        } else if (state is GetBloodBankLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetBloodBankSuccess) {
                          return BloodBankListView(
                            bloodBanks: state.bloodBanks,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
