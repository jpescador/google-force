@isTest
private class GoogleSheets_Test {

    private static GoogleForce gForce;
    private static GoogleSheets sheets;
    private static String spreadsheetId = 'testSpreadsheetId';

    static {
        gForce = new GoogleForce('unitTestAcct');
        sheets = new GoogleSheets(gForce);
    }

    @isTest static void batchGet() {

        GoogleSheets.BatchGetValuesResponse batchGetValsRespMock =
            new GoogleSheets.BatchGetValuesResponse();

        GoogleSheets.ValueRange valueRangeMock = new GoogleSheets.ValueRange();
        valueRangeMock.setRange('Sheet1!A1:E1').setMajorDimension('ROWS').setValues(
            new List<List<String>>{
                new List<String>{ '1', '2', '3', '4', '5' }
            });

        batchGetValsRespMock.setSpreadsheetId(spreadsheetId)
            .setValueRanges(new List<GoogleSheets.ValueRange>{
                valueRangeMock
            });

        Test.setMock(HttpCalloutMock.class, new GoogleMockResponse(200,
            'OK', JSON.serialize(batchGetValsRespMock, true), null));

        Test.startTest();

        GoogleSheets.BatchGetValuesResponse batchGetResp = sheets.spreadsheets().values().batchGet(
            spreadsheetId)
            .setRanges(new List<String>{ 'A1:E1' })
            .setMajorDimension('ROWS')
            .execute();

        Test.stopTest();

        System.assertEquals(batchGetValsRespMock.getSpreadsheetId(),
            batchGetResp.getSpreadsheetId());

        System.assertEquals(batchGetValsRespMock.getValueRanges().get(0).getValues(),
            batchGetResp.getValueRanges().get(0).getValues());
    }

    @isTest static void batchUpdate() {

        GoogleSheets.BatchUpdateValuesResponse batchUpdateValsRespMock =
            new GoogleSheets.BatchUpdateValuesResponse();

        batchUpdateValsRespMock.setSpreadsheetId(spreadsheetId)
            .setTotalUpdatedCells(1)
            .setTotalUpdatedColumns(1)
            .setTotalUpdatedRows(1)
            .setTotalUpdatedSheets(1);

        GoogleSheets.UpdateValuesResponse updateValuesResponseMock =
            new GoogleSheets.UpdateValuesResponse();
        updateValuesResponseMock.setSpreadsheetId(spreadsheetId)
            .setUpdatedCells(1)
            .setUpdatedColumns(1)
            .setUpdatedRows(1)
            .setUpdatedRange('Sheet1!A1');

        GoogleSheets.ValueRange valueRangeResponseMock = new GoogleSheets.ValueRange()
            .setRange('Sheet1!A1:B1')
            .setMajorDimension('ROWS')
            .setValues(new List<List<String>>{
                new List<String>{ '1', '2' }
            });
        updateValuesResponseMock.setUpdatedData(valueRangeResponseMock);

        batchUpdateValsRespMock.setResponses(new List<GoogleSheets.UpdateValuesResponse>{
            updateValuesResponseMock
        });

        Test.setMock(HttpCalloutMock.class, new GoogleMockResponse(200,
            'OK', JSON.serialize(batchUpdateValsRespMock, true), null));

        Test.startTest();

        List<GoogleSheets.ValueRange> data = new List<GoogleSheets.ValueRange>();

        data.add(new GoogleSheets.ValueRange()
            .setRange('A1:B1')
            .setMajorDimension('ROWS')
            .setValues(new List<List<String>>{
                new List<String>{ '1' }
            }));

        GoogleSheets.BatchUpdateRequest body = new GoogleSheets.BatchUpdateRequest()
            .setIncludeValuesInResponse(true)
            .setValueInputOption('USER_ENTERED')
            .setData(data);

        GoogleSheets.BatchUpdateValuesResponse batchValsResp = sheets.spreadsheets().values()
            .batchUpdate(spreadsheetId, body).execute();

        Test.stopTest();

        System.assertEquals(
            batchUpdateValsRespMock.getResponses().get(0).getUpdatedData().getValues().get(0).get(1),
            batchValsResp.getResponses().get(0).getUpdatedData().getValues().get(0).get(1));

    }

    @isTest static void getRange() {

        GoogleSheets.ValueRange valueRangeMock = new GoogleSheets.ValueRange();
        valueRangeMock.setRange('Sheet1!A1:E1').setMajorDimension('ROWS').setValues(
            new List<List<String>>{
                new List<String>{ '1', '2', '3', '4', '5' }
            });

        Test.setMock(HttpCalloutMock.class, new GoogleMockResponse(200,
            'OK', JSON.serialize(valueRangeMock, true), null));

        Test.startTest();

        GoogleSheets.ValueRange getValsResp = sheets.spreadsheets().values().getRange(
            spreadsheetId, 'A1:E1')
            .setMajorDimension('ROWS')
            .execute();

        Test.stopTest();

        System.assertEquals(valueRangeMock.getMajorDimension(), getValsResp.getMajorDimension());
        System.assertEquals(valueRangeMock.getRange(), getValsResp.getRange());
        System.assertEquals(valueRangeMock.getValues(), getValsResp.getValues());
    }

    @isTest static void updateRange() {

        GoogleSheets.UpdateValuesResponse updateValuesResponseMock =
            new GoogleSheets.UpdateValuesResponse();
        updateValuesResponseMock.setSpreadsheetId(spreadsheetId)
            .setUpdatedCells(1)
            .setUpdatedColumns(1)
            .setUpdatedRows(1)
            .setUpdatedRange('Sheet1!A1');

        GoogleSheets.ValueRange valueRangeResponseMock = new GoogleSheets.ValueRange()
            .setRange('Sheet1!A1:B1')
            .setMajorDimension('ROWS')
            .setValues(new List<List<String>>{
                new List<String>{ '1', '2' }
            });
        updateValuesResponseMock.setUpdatedData(valueRangeResponseMock);

        Test.setMock(HttpCalloutMock.class, new GoogleMockResponse(200,
            'OK', JSON.serialize(updateValuesResponseMock, true), null));

        Test.startTest();

        GoogleSheets.ValueRange valueRange = new GoogleSheets.ValueRange()
            .setMajorDimension('ROWS')
            .setValues(new List<List<String>>{
                new List<String>{ '1' }
            });

        GoogleSheets.UpdateValuesResponse valsResp = sheets.spreadsheets().values().updateRange(
            '1OG3iEFN-prmiIS7Fqhd078WUyid_9Na97lroinaHu3I', 'A1:B2', valueRange)
            .setIncludeValuesInResponse(true)
            .setValueInputOption('USER_ENTERED')
            .execute();

        Test.stopTest();

        System.assertEquals(updateValuesResponseMock.getSpreadsheetId(),
            valsResp.getSpreadsheetId());

        System.assertEquals(updateValuesResponseMock.getUpdatedCells(),
            valsResp.getUpdatedCells());

        System.assertEquals(updateValuesResponseMock.getUpdatedColumns(),
            valsResp.getUpdatedColumns());

        System.assertEquals(updateValuesResponseMock.getUpdatedRange(),
            valsResp.getUpdatedRange());

        System.assertEquals(updateValuesResponseMock.getUpdatedRows(),
            valsResp.getUpdatedRows());

    }

}