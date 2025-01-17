import 'package:bhumi_mobile/features/onboarding/presentation/view/on_board_model.dart';
import 'package:bhumi_mobile/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: SafeArea(
          child: BlocBuilder<OnboardingCubit, int>(
            builder: (context, currentPage) {
              final cubit = context.read<OnboardingCubit>();
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: cubit.pageController,
                      onPageChanged: (index) {
                        cubit.emit(index);
                      },
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        final data = pages[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.4,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromRGBO(55, 95, 22, 1),
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage(data.imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              data.title,
                              style: const TextStyle(
                                color: Color.fromRGBO(55, 95, 22, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                data.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            cubit.skipToLastPage();
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Color.fromRGBO(58, 168, 89, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: List.generate(pages.length, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: currentPage == index ? 12 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: currentPage == index
                                    ? const Color.fromRGBO(58, 168, 89, 1)
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (currentPage == pages.length - 1) {
                              cubit.navigateToAuthScreen(context);
                            } else {
                              cubit.goToNextPage();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(58, 168, 89, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            currentPage == pages.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
