# MSSQL-Database-Insights widget

This collection of widgets are designed to provide insights into MSSQL Database to further extend the built-in default widgets.

Where possible all of these widgets will include more detail when you click *_Show Details_* from the widget menu.

<img src="https://raw.githubusercontent.com/Matticusau/sqlops-mssql-db-insights/master/src/images/show-detail.png" alt="Show Details" />

## Installation

The current release will be available through the Extensions Marketplace in Sql Ops Studio.

Current and Pre-releases will be available from the [Releases](https://github.com/Matticusau/sqlops-mssql-db-insights/releases) tab of the projects repository. Simply download the VSIX of the release you want, and use the ***Install Extension from VSIX Package*** option in Sql Ops Studio.

## Supported SQL Server Versions

These widgets have been tested against the following SQL Server versions:

* SQL Server 2008R2
* SQL Server 2012
* SQL Server 2014
* SQL Server 2016
* SQL Server 2017 (Windows & linux)
* Azure SQL Db

If you find any issues using these widgets on these supported SQL Server versions, or any other versions please create an issue as we would like to make these available for as many releases as possible.

Thanks to the following people for testing:

* Sreekanth [@mssqltrek](https://twitter.com/mssqltrek)

***We are looking for testers to confirm other environments.*** So if you find they do work on other releases let me know, and credit will be given.

## Dashboard Tab

When the extension is loaded it will add a Dashboard tab. You can edit your workspace settings in the *dashboard.server.tabs* section to include this on your specific projects.

<img src="https://raw.githubusercontent.com/Matticusau/sqlops-mssql-db-insights/master/src/images/mssql-db-insights-tab.png" alt="mssql-db-insights-tab.png" style="width:800px;" />

## mssql-db-spaceused

This Database Dashboard widget includes information on the current used space within a Database. Information will be shown in the form of a pie chart displaying the percentage of used space verses free space.

<img src="https://raw.githubusercontent.com/Matticusau/sqlops-mssql-db-insights/master/src/images/mssql-db-spaceused.png" alt="mssql-db-spaceused.png" />

You can access more information about the space usaged in the detailed fly-out displayed when you select "..." on the widget.

<img src="https://raw.githubusercontent.com/Matticusau/sqlops-mssql-db-insights/master/src/images/mssql-db-spaceused-details.png" alt="mssql-db-spaceused-details.png" />

To enable this widget add the following json to either your user or workspace settings in the *dashboard.database.widgets* section.

```json
{
    "widget": {
        "mssql-db-spaceused.insight": {
            "cacheId": "1d7cba8b-c87a-4bcc-ae54-2f40a5503a90"
        }
    }
}
```

## mssql-db-spaceused-filetype

This Database Dashboard widget includes information on the current used space within a Database broken down by the various file types (ROWS, LOG). Information will be shown in the form of a bar chart displaying the percentage of used space verses free space for each file type.

<img src="https://raw.githubusercontent.com/Matticusau/sqlops-mssql-db-insights/master/src/images/mssql-db-spaceused-filetype.png" alt="mssql-db-spaceused-filetype.png" />

You can access more information about the space usaged in the detailed fly-out displayed when you select "..." on the widget.

<img src="https://raw.githubusercontent.com/Matticusau/sqlops-mssql-db-insights/master/src/images/mssql-db-spaceused-details.png" alt="mssql-db-spaceused-details.png" />

To enable this widget add the following json to either your user or workspace settings in the *dashboard.database.widgets* section.

```json
{
    "widget": {
        "mssql-db-spaceused-filetype.insight": {
            "cacheId": "1d7cba8b-c87a-4bcc-ae54-2f40a5503a90"
        }
    }
}
```

## mssql-db-vlfs

This Database Dashboard widget includes information on the number of VLfs in the current database on the SQL Instance. Information will be shown in the form of a bar chart.

This insight is ***not*** supported on Azure SQL Db.

<img src="https://raw.githubusercontent.com/Matticusau/sqlops-mssql-db-insights/master/src/images/mssql-db-vlfs.png" alt="mssql-db-vlfs.png" />

You can access more information about the vlfs in the detailed fly-out displayed when you select "..." on the widget.

<img src="https://raw.githubusercontent.com/Matticusau/sqlops-mssql-db-insights/master/src/images/mssql-db-vlfs-details.png" alt="mssql-db-vlfs-details.png" />

To enable this widget add the following json to either your user or workspace settings in the *dashboard.database.widgets* section.

```json
{
    "widget": {
        "mssql-db-vlfs.insight": {
            "cacheId": "1d7cba8b-c87a-4bcc-ae54-2f40a5503a90"
        }
    }
}
```