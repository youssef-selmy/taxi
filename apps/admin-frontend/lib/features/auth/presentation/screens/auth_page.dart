import 'package:admin_frontend/core/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/components/onboarding/onboarding.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/auth/presentation/blocs/auth.bloc.dart';
import 'package:admin_frontend/features/auth/presentation/dialogs/disable_server.dart';
import 'package:admin_frontend/gen/assets.gen.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: locator<AuthBloc>(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.activateServerResponse) {
              case ApiResponseLoaded(:final data):
                switch (data.updatePurchaseCode.status) {
                  case Enum$UpdatePurchaseCodeStatus.CLIENT_FOUND:
                    showDialog(
                      context: context,
                      builder: (context) => DisableServerDialog(
                        clients: data.updatePurchaseCode.clients!,
                      ),
                    );
                    break;
                  case Enum$UpdatePurchaseCodeStatus.OK:
                    context.router.replace(const LicenseInformationRoute());
                    break;
                  case Enum$UpdatePurchaseCodeStatus.INVALID:
                    context.showToast(
                      context.tr.invalidLicenseKey,
                      type: SemanticColor.error,
                    );
                    break;
                  case Enum$UpdatePurchaseCodeStatus.OVERUSED:
                    context.showToast(
                      context.tr.licenseKeyOverused,
                      type: SemanticColor.error,
                    );
                    break;
                  case Enum$UpdatePurchaseCodeStatus.$unknown:
                    context.showToast(
                      context.tr.unknownError,
                      type: SemanticColor.error,
                    );
                    break;
                }
                break;

              case ApiResponseError(:final errorMessage):
                context.showToast(
                  errorMessage ?? context.tr.somethingWentWrong,
                  type: SemanticColor.error,
                );
                break;

              default:
                break;
            }

            switch (state.disableServerResponse) {
              case ApiResponseLoaded(:final data):
                if (data.status == Enum$UpdateConfigStatus.OK) {
                  context.router.replace(const LicenseInformationRoute());
                } else {
                  context.showToast(context.tr.unknownError);
                }
                break;

              case ApiResponseError(:final errorMessage):
                context.showToast(
                  errorMessage ?? context.tr.somethingWentWrong,
                );
                break;

              default:
                break;
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Assets.images.companyLogo.image(
                                  width: 80,
                                  height: 80,
                                  isAntiAlias: true,
                                  filterQuality: FilterQuality.high,
                                ),
                                const SizedBox(height: 40),
                                Text(
                                  context.tr.welcomeHeader(Env.appName),
                                  style: context.textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  context.tr.licenseKeyAndEmailPrompt,
                                  style: context.textTheme.bodyMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                // License key in uuid format
                                AppTextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(36),
                                    // TextInputFormatter.withFunction(
                                    //   (oldValue, newValue) {
                                    //     if (newValue.text.length == 8 ||
                                    //         newValue.text.length == 13 ||
                                    //         newValue.text.length == 18 ||
                                    //         newValue.text.length == 23) {
                                    //       return TextEditingValue(
                                    //         text: "${newValue.text}-",
                                    //         selection: TextSelection.collapsed(
                                    //           offset: newValue.selection.end + 1,
                                    //         ),
                                    //       );
                                    //     }
                                    //     return newValue;
                                    //   },
                                    // ),
                                  ],
                                  onSaved: (p0) {
                                    context
                                        .read<AuthBloc>()
                                        .onLicenseKeyChanged(p0);
                                  },
                                  initialValue: state.purchaseCode,
                                  label: context.tr.licenseKey,
                                  isFilled: true,
                                ),
                                const SizedBox(height: 16),
                                AppTextField(
                                  controller: TextEditingController(
                                    text: state.email,
                                  ),
                                  validator: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return context.tr.errorEmailRequired;
                                    }
                                    // Regex validate email
                                    if (!RegExp(
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                                    ).hasMatch(p0)) {
                                      return context.tr.errorEmailInvalid;
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                  onSaved: (p0) {
                                    context.read<AuthBloc>().onEmailChanged(p0);
                                  },
                                  label: context.tr.email,
                                  isFilled: true,
                                ),
                                const SizedBox(height: 32),
                                SizedBox(
                                  width: double.infinity,
                                  child: BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                      return AppFilledButton(
                                        text: context.tr.confirm,
                                        isLoading: state
                                            .activateServerResponse
                                            .isLoading,
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            context
                                                .read<AuthBloc>()
                                                .activateServer();
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (context.isDesktop) ...[
                Expanded(
                  child: Container(
                    color: context.colors.surfaceVariant,
                    height: double.infinity,
                    child: const Column(
                      children: [Spacer(), Onboarding(), Spacer()],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
