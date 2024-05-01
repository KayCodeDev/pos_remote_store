import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../core/providers/global_provider.dart';
import '../../../utils/components/loader.dart';
import '../../widgets/base_provider_widget.dart';
import 'remote_provider.dart';

class RemotePage extends StatefulWidget {
  const RemotePage({super.key});

  @override
  State<RemotePage> createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusNodeRemoteId = FocusNode();

  @override
  void dispose() {
    _focusNodeRemoteId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
        builder: (_, gp, __) => BaseProviderWidget<RemoteProvider>(
            model: RemoteProvider(
              globalProvider: gp,
              apiRepository: Provider.of(context),
            ),
            // onModelReady: (model) => model.initState(),
            builder: (context, model, child) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const Text("Remote Support"),
                ),
                body: _buildBody(model, gp))));
  }

  Widget _buildBody(RemoteProvider model, GlobalProvider gp) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        children: [
          const Text("Enter the remote connection ID"),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.text,
            readOnly: model.isGettingRemote,
            controller: model.remoteIdController,
            focusNode: _focusNodeRemoteId,
            validator: (value) {
              return value!.isEmpty || value!.length < 5
                  ? "Enter a valid remote connection ID"
                  : null;
            },
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Remote Connection ID',
              border: OutlineInputBorder(),

            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: model.isGettingRemote ? null : () {
              FocusScope.of(context)
                  .requestFocus(FocusNode());
              if (_formKey.currentState!.validate()) {
                model.validateConnection();
              }
            },
            child: model.isGettingRemote
                ? const Loader(size: 25, strokes: 3)
                : const Text("Connect"),
          )
        ],
      ),
    );
  }
}
