//
// Author:  Matt Lavery
// Date:    02/07/2018
// Purpose: extension entry module
//
// When         Who         What
// ------------------------------------------------------------------------------------------
// 02/07/2018   MLavery     Strictly set 'any' types to fix src\extension.ts(50,55): error TS7006: Parameter 'connection' implicitly has an 'any' type.
//

'use strict';
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';

// The module 'sqlops' contains the SQL Operations Studio extensibility API
// This is a complementary set of APIs that add SQL / Data-specific functionality to the app
// Import the module and reference it with the alias sqlops in your code below

import * as sqlops from 'sqlops';

// import the controller
import ControllerBase from './controllers/controllerBase';
import MainController from './controllers/mainController';

let controllers: ControllerBase[] = [];


// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {

    // taken from the extensionSamples
    let activations: Promise<boolean>[] = [];

    // Start the main controller
    let mainController = new MainController(context);
    controllers.push(mainController);
    context.subscriptions.push(mainController);
    activations.push(mainController.activate());

    // Use the console to output diagnostic information (console.log) and errors (console.error)
    // This line of code will only be executed once when your extension is activated
    console.log('Congratulations, your extension "mssql-db-insights" is now active!');

    // The command has been defined in the package.json file
    // Now provide the implementation of the command with  registerCommand
    // The commandId parameter must match the command field in package.json
    context.subscriptions.push(vscode.commands.registerCommand('extension.sayHello', () => {
        // The code you place here will be executed every time your command is executed

        // Display a message box to the user
        vscode.window.showInformationMessage('Hello World!');
    }));

    context.subscriptions.push(vscode.commands.registerCommand('extension.showCurrentConnection', () => {
        // The code you place here will be executed every time your command is executed

        // Display a message box to the user
        sqlops.connection.getCurrentConnection().then((connection: any) => {
            let connectionId = connection ? connection.connectionId : 'No connection found!';
            vscode.window.showInformationMessage(connectionId);
        }, (error: any) => {
             console.info(error);
        });
    }));

    // activations - from extensionSamples
    return Promise.all(activations)
        .then((results: boolean[]) => {
            for (let result of results) {
                if (!result) {
                    return false;
                }
            }
            return true;
        });
}

// this method is called when your extension is deactivated
export function deactivate() {
    // deactive any controllers we loaded
    for (let controller of controllers) {
        controller.deactivate();
    }
}