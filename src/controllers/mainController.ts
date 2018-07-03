//
// Author:  Matt Lavery
// Date:    02/07/2018
// Purpose: Main Controller
//
// When         Who         What
// ------------------------------------------------------------------------------------------
// 02/07/2018   MLavery     Strictly set 'any' types to fix src\extension.ts(50,55): error TS7006: Parameter 'connection' implicitly has an 'any' type.
//

/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the Source EULA. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/

'use strict';

import * as vscode from 'vscode';
import * as sqlops from 'sqlops';
import * as Utils from '../utils';
import ControllerBase from './controllerBase';
import * as fs from 'fs';
import * as path from 'path';
import * as dbprops from './dbPropsController';

/**
 * The main controller class that initializes the extension
 */
export default class MainController extends ControllerBase {
    // PUBLIC METHODS //////////////////////////////////////////////////////
    /**
     * Deactivates the extension
     */
    public deactivate(): void {
        Utils.logDebug('Main controller deactivated');
    }

    public activate(): Promise<boolean> {
        
        // const webviewExampleHtml = fs.readFileSync(path.join(__dirname, 'webviewExample.html')).toString();
        // const buttonHtml = fs.readFileSync(path.join(__dirname, 'button.html')).toString();
        // const counterHtml = fs.readFileSync(path.join(__dirname, 'counter.html')).toString();

        // let countWidget: sqlops.DashboardWebview;
        // let buttonWidget: sqlops.DashboardWebview;
        // let count = 0;

        // let dialog: sqlops.ModalDialog = sqlops.window.createDialog('Flyout extension');
        // dialog.html = '<div>This is a flyout extension.</div>';

        // sqlops.dashboard.registerWebviewProvider('webview-count', e => {
        //     e.html = counterHtml;
        //     countWidget = e;
        // });
        // sqlops.dashboard.registerWebviewProvider('webview-button', e => {
        //     e.html = buttonHtml;
        //     buttonWidget = e;
        //     e.onMessage(event => {
        //         if (event === 'openFlyout') {
        //             dialog.open();
        //         } else {
        //             count++;
        //             countWidget.postMessage(count);
        //         }
        //     });
        // });
        // sqlops.dashboard.registerWebviewProvider('webviewExample', e => {
        //     e.html = webviewExampleHtml;
        // });

        // const dbpropertiesHtml = fs.readFileSync(path.join(__dirname, 'dbProperties.html')).toString();
        // console.log('dbpropertiesHtml'+dbpropertiesHtml);
        
        sqlops.dashboard.registerWebviewProvider('dbproperties', (e: any) => {
            dbprops.getDbProperties()
            .then(dbpropertiesValues => {
                console.log('dbpropertiesValues:'+JSON.stringify(dbpropertiesValues));
                Utils.renderTemplateHtml(path.join(__dirname, '..'), 'dbProperties.html', dbpropertiesValues)
                    .then(html => {
                        console.log('dbpropertiesHtml'+html);
                        console.log('setting e.html');
                        e.html = html;
                    });
                });
            //console.log('setting e.html to dbpropertiesHtml');
            //e.html = dbpropertiesHtml;
        });

        //
        // register the commands
        //
        vscode.commands.registerCommand('extension.sayHello', () => {
            // The code you place here will be executed every time your command is executed
    
            // Display a message box to the user
            vscode.window.showInformationMessage('Hello World!');
        });

        vscode.commands.registerCommand('extension.showCurrentConnection', () => {
            // The code you place here will be executed every time your command is executed
    
            // Display a message box to the user
            sqlops.connection.getCurrentConnection().then((connection: any) => {
                let connectionId = connection ? connection.connectionId : 'No connection found!';
                vscode.window.showInformationMessage(connectionId);
            }, (error: any) => {
                 console.info(error);
            });
        });

        return Promise.resolve(true);
    }
}

