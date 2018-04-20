# Welcome to your SQL Operations Studio Extension

## What's in the folder
* This folder contains all of the files necessary for your dashboard insight extension.
* `package.json` - this is the manifest file that defines the list of insights and new dashboard tabs for the extension. Open this in SQL Operations Studio and edit the `contributes` section to add new features.
  * `dashboard.insights` section is where your insight definition is added. This is a bar chart insight by default. You can add additional insights here
  * `dashboard.tabs` section is where you register a new "tab" or area in the dashboard for your extension, and include your new insight. If you select `No` for the `Add a full dashboard tab?` question this will not be added, and instead you can use the insight in other tabs / in the home tab.
* `sql/query.sql` - this is the file your first insight widget query should be added to.


## Get up and running straight away
* Press `F5` to open a new window with your extension loaded.
* Press `Ctrl + .` instead of `Ctrl + Shift + P`
* Verify that it will launch the Command Palette listing all available commands. The `Ctrl + .` keyboard shortcut was added as an example to you.

## Make changes
* You can relaunch the extension from the debug toolbar after making changes to the files listed above.
* You can also reload (`Ctrl+R` or `Cmd+R` on Mac) the SQL Operations Studio window with your extension to load your changes.

## Install your extension
* To start using your extension with SQL Operations Studio copy it into the `<user home>/.sqlops/extensions` folder and restart SqlOps.
* To share your extension with the world, read on https://github.com/microsoft/sqlopsstudio/wiki/Getting-started-with-Extensibility about publishing an extension.
