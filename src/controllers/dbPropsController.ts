//
// Author:  Matt Lavery
// Date:    03/07/2018
// Purpose: db Properites
//
// When         Who         What
// ------------------------------------------------------------------------------------------
// 03/07/2018   MLavery     Initial coding
//


'use strict';

import * as vscode from 'vscode';
import * as sqlops from 'sqlops';

export function getDbProperties(): Thenable<any> {
    
    return sqlops.connection.getCurrentConnection().then((connection: any) => {
        console.log('connection: '+JSON.stringify(connection));
        let dbpropertiesValues = { name: 'Test DB', collation: 'Latin something something' };
        return dbpropertiesValues;
        // vscode.window.showInformationMessage(connectionId);
    }, (error: any) => {
         console.info(error);
         return {};
    });
}
