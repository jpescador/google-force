@isTest
private class GoogleDrive_Test {

    private static GoogleForce gForce;
    private static GoogleDrive drive;
    private static String spreadsheetId;
    private static String copiedFiledId;

    static {
        gForce = new GoogleForce('unitTestAcct');
        drive = new GoogleDrive(gForce);
        spreadsheetId = 'testSpreadsheetId';
        copiedFiledId = '12345';
    }

    @isTest static void copy() {

        GoogleDrive.File fileMock = new GoogleDrive.File();
        fileMock.setId(copiedFiledId).setName('test copy');

        Test.setMock(HttpCalloutMock.class, new GoogleMockResponse(200,
            'OK', JSON.serialize(fileMock, true), null));

        Test.startTest();
        GoogleDrive.File copyResp = drive.files().copy(spreadsheetId,
            new GoogleDrive.File().setName('test copy')).execute();
        Test.stopTest();

        System.assertEquals(fileMock.getId(), copyResp.getId());
        System.assertEquals(fileMock.getName(), copyResp.getName());
    }

    @isTest static void deleteFile() {
        Test.setMock(HttpCalloutMock.class, new GoogleMockResponse(200,
            'OK', '{}', null));

        Test.startTest();
        Boolean isDeleted = drive.files().deleteFile(copiedFiledId).execute();
        Test.stopTest();

        System.assertEquals(true, isDeleted);
    }

    @isTest static void listFiles() {
        GoogleDrive.FileList fileListMock = new GoogleDrive.FileList();
        fileListMock.setKind('drive#fileList')
            .setIncompleteSearch(false)
            .setFiles(new List<GoogleDrive.File>{
                (new GoogleDrive.File().setId(spreadsheetId).setName('spreadsheet')),
                (new GoogleDrive.File().setId(copiedFiledId).setName('test copy'))
            });

        Test.setMock(HttpCalloutMock.class, new GoogleMockResponse(200,
            'OK', JSON.serialize(fileListMock), null));

        Test.startTest();
        GoogleDrive.FileList fileListResp = drive.files().listFiles().execute();
        Test.stopTest();

        System.assertEquals(fileListMock.getKind(), fileListResp.getKind());
        System.assertEquals(fileListMock.getIncompleteSearch(), fileListResp.getIncompleteSearch());
        System.assertEquals(fileListMock.getFiles().size(), fileListResp.getFiles().size());
    }

}