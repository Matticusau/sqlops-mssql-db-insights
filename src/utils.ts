//
// Author:  Matt Lavery
// Date:    02/07/2018
// Purpose: Utils
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

import * as fs from 'fs-extra';
import * as handlebars from 'handlebars';
import * as path from 'path';
import * as vscode from 'vscode';

import * as Constants from './constants';
import * as LocalizedConstants from './localizedConstants';

/**
 * Helper to log messages to the developer console if enabled
 * @param msg Message to log to the console
 */
export function logDebug(msg: any): void {
    let config = vscode.workspace.getConfiguration(Constants.extensionConfigSectionName);
    let logDebugInfo = config[Constants.configLogDebugInfo];
    if (logDebugInfo === true) {
        let currentTime = new Date().toLocaleTimeString();
        let outputMsg = '[' + currentTime + ']: ' + msg ? msg.toString() : '';
        console.log(outputMsg);
    }
}

export function renderTemplateHtml(extensionPath: string, templateName: string, templateValues: object): Thenable<string> {
    // let templatePath = path.join(extensionPath, 'resources', templateName);
    let templatePath: string = path.join(extensionPath, 'resources', templateName);

    // 1) Read the template from the disk
    // 2) Compile it as a handlebars template and render the HTML
    // 3) On failure, return a simple string as an error
    return fs.readFile(templatePath, 'utf-8')
        .then((templateText: string) => {
            let template = handlebars.compile(templateText);
            return template(templateValues);
        })
        .then(
            undefined,
            (error: any) => {
                logDebug(error);
                return LocalizedConstants.msgErrorLoadingTab;
            }
        );
}


