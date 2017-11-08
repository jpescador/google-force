public class GoogleSheets {

    private static final String rootUrl = 'https://sheets.googleapis.com/v4/spreadsheets';
    private GoogleForce gForce;

    public GoogleSheets(GoogleForce gForce) {
        this.gForce = gForce;
    }

    public class Spreadsheets {
        private GoogleSheets gSheet;

        public Spreadsheets(GoogleSheets gSheet) {
            this.gSheet = gSheet;
        }

        public Values values() {
            return new Values(this);
        }
    }

    public class Values {
        private Spreadsheets gSpreadsheet;

        public Values(Spreadsheets gSpreadsheet) {
            this.gSpreadsheet = gSpreadsheet;
        }

        public BatchGet batchGet(String spreadsheetId) {
            return new BatchGet(this, spreadsheetId);
        }

        public BatchUpdate batchUpdate(String spreadsheetId, BatchUpdateRequest content) {
            return new BatchUpdate(this, spreadsheetId, content);
        }

        public GetRange getRange(String spreadsheetId, String range) {
            return new GetRange(this, spreadsheetId, range);
        }

        public UpdateRange updateRange(String spreadsheetId, String range, ValueRange valueRange) {
            return new UpdateRange(this, spreadsheetId, range, valueRange);
        }
    }

    public class BatchGet {

        private Values gValues;
        private String queryParams;
        private String spreadsheetId;

        public BatchGet(Values gValues, String spreadsheetId) {
            this.gValues = gValues;
            this.queryParams = '';
            this.spreadsheetId = spreadsheetId;
        }

        public BatchGet setDateTimeRenderOption(String dateTimeRenderOption) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'dateTimeRenderOption', dateTimeRenderOption);
            return this;
        }

        public BatchGet setMajorDimension(String majorDimension) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'majorDimension', majorDimension);
            return this;
        }

        public BatchGet setRanges(List<String> ranges) {
            for (String range : ranges) {
                queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                    'ranges', range);
            }
            return this;
        }

        public BatchGet setValueRenderOption(String valueRenderOption) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'valueRenderOption', valueRenderOption);
            return this;
        }

        public BatchGetValuesResponse execute() {
            String endpoint = GoogleSheets.rootUrl + '/' + spreadsheetId + '/values:batchGet';

            GoogleForce gForce = gValues.gSpreadsheet.gSheet.gForce;
            HttpResponse resp = gForce.sendRequest(new Map<String, String>{
                'method'   => 'GET',
                'endpoint' => endpoint + queryParams
            });

            return (BatchGetValuesResponse) JSON.deserialize(
                gForce.handleResponse(resp), BatchGetValuesResponse.class);
        }
    }

    public class BatchGetValuesResponse {
        private String spreadsheetId;
        private List<ValueRange> valueRanges;

        public String getSpreadsheetId() {
            return spreadsheetId;
        }

        public List<ValueRange> getValueRanges() {
            return valueRanges;
        }
    }

    public class BatchUpdate {

        private Values gValues;
        private String spreadsheetId;
        private BatchUpdateRequest content;

        public BatchUpdate(Values gValues, String spreadsheetId, BatchUpdateRequest content) {
            this.gValues = gValues;
            this.spreadsheetId = spreadsheetId;
            this.content = content;
        }

        public BatchUpdateValuesResponse execute() {
            String endpoint = GoogleSheets.rootUrl + '/' + spreadsheetId + '/values:batchUpdate';
            String jsonBody = JSON.serialize(content, true);

            GoogleForce gForce = gValues.gSpreadsheet.gSheet.gForce;
            HttpResponse resp = gForce.sendRequest(new Map<String, String>{
                'method'   => 'POST',
                'endpoint' => endpoint,
                'body' => jsonBody
            });

            return (BatchUpdateValuesResponse) JSON.deserialize(
                gForce.handleResponse(resp), BatchUpdateValuesResponse.class);
        }

    }

    public class BatchUpdateRequest {
        private List<ValueRange> data;
        private Boolean includeValuesInResponse;
        private String responseDateTimeRenderOption;
        private String responseValueRenderOption;
        private String valueInputOption;

        public BatchUpdateRequest setData(List<ValueRange> data) {
            this.data = data;
            return this;
        }

        public BatchUpdateRequest setIncludeValuesInResponse(Boolean includeValuesInResponse) {
            this.includeValuesInResponse = includeValuesInResponse;
            return this;
        }

        public BatchUpdateRequest setResponseDateTimeRenderOption(String responseDateTimeRenderOption) {
            this.responseDateTimeRenderOption = responseDateTimeRenderOption;
            return this;
        }

        public BatchUpdateRequest setResponseValueRenderOption(String responseValueRenderOption) {
            this.responseValueRenderOption = responseValueRenderOption;
            return this;
        }

        public BatchUpdateRequest setValueInputOption(String valueInputOption) {
            this.valueInputOption = valueInputOption;
            return this;
        }
    }

    public class BatchUpdateValuesResponse {
        private List<UpdateValuesResponse> responses;
        private String  spreadsheetId;
        private Integer totalUpdatedCells;
        private Integer totalUpdatedColumns;
        private Integer totalUpdatedRows;
        private Integer totalUpdatedSheets;

        public List<UpdateValuesResponse> getResponses() {
            return responses;
        }

        public String getSpreadsheetId() {
            return spreadsheetId;
        }

        public Integer getTotalUpdatedCells() {
            return totalUpdatedCells;
        }

        public Integer getTotalUpdatedColumns() {
            return totalUpdatedColumns;
        }

        public Integer getTotalUpdatedRows() {
            return totalUpdatedRows;
        }

        public Integer getTotalUpdatedSheets() {
            return totalUpdatedSheets;
        }

        public BatchUpdateValuesResponse setResponses(List<UpdateValuesResponse> responses) {
            this.responses = responses;
            return this;
        }

        public BatchUpdateValuesResponse setSpreadsheetId(String spreadsheetId) {
            this.spreadsheetId = spreadsheetId;
            return this;
        }

        public BatchUpdateValuesResponse setTotalUpdatedCells(Integer totalUpdatedCells) {
            this.totalUpdatedCells = totalUpdatedCells;
            return this;
        }

        public BatchUpdateValuesResponse setTotalUpdatedColumns(Integer totalUpdatedColumns) {
            this.totalUpdatedColumns = totalUpdatedColumns;
            return this;
        }

        public BatchUpdateValuesResponse setTotalUpdatedRows(Integer totalUpdatedRows) {
            this.totalUpdatedRows = totalUpdatedRows;
            return this;
        }

        public BatchUpdateValuesResponse setTotalUpdatedSheets(Integer totalUpdatedSheets) {
            this.totalUpdatedSheets = totalUpdatedSheets;
            return this;
        }
    }

    public class GetRange {

        private Values gValues;
        private String queryParams;
        private String range;
        private String spreadsheetId;

        public GetRange(Values gValues, String spreadsheetId, String range) {
            this.gValues = gValues;
            this.queryParams = '';
            this.range = range;
            this.spreadsheetId = spreadsheetId;
        }

        public GetRange setDateTimeRenderOption(String dateTimeRenderOption) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'dateTimeRenderOption', dateTimeRenderOption);
            return this;
        }

        public GetRange setMajorDimension(String majorDimension) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'majorDimension', majorDimension);
            return this;
        }

        public GetRange setValueRenderOption(String valueRenderOption) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'valueRenderOption', valueRenderOption);
            return this;
        }

        public ValueRange execute() {
            String endpoint = GoogleSheets.rootUrl + '/' + spreadsheetId + '/values/' + range;

            GoogleForce gForce = gValues.gSpreadsheet.gSheet.gForce;
            HttpResponse resp = gForce.sendRequest(new Map<String, String>{
                'method'   => 'GET',
                'endpoint' => endpoint + queryParams
            });

            return (ValueRange) JSON.deserialize(
                gForce.handleResponse(resp), ValueRange.class);
        }
    }

    public class UpdateRange {
        private ValueRange content;
        private Values gValues;
        private String queryParams;
        private String range;
        private String spreadsheetId;

        public UpdateRange(Values gValues, String spreadsheetId, String range, ValueRange content) {
            this.content = content;
            this.gValues = gValues;
            this.queryParams = '';
            this.range = range;
            this.spreadsheetId = spreadsheetId;
        }

        public UpdateRange setIncludeValuesInResponse(Boolean includeValuesInResponse) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'includeValuesInResponse', String.valueOf(includeValuesInResponse));
            return this;
        }

        public UpdateRange setResponseDateTimeRenderOption(String dateTimeRenderOption) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'responseDateTimeRenderOption', dateTimeRenderOption);
            return this;
        }

        public UpdateRange setResponseValueRenderOption(String valueRenderOption) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'responseValueRenderOption', valueRenderOption);
            return this;
        }

        public UpdateRange setValueInputOption(String valueInputOption) {
            queryParams = gValues.gSpreadsheet.gSheet.appendParam(queryParams,
                'valueInputOption', valueInputOption);
            return this;
        }

        public UpdateValuesResponse execute() {
            String endpoint = GoogleSheets.rootUrl + '/' + spreadsheetId + '/values/' + range;
            String jsonBody = JSON.serialize(content, true);

            GoogleForce gForce = gValues.gSpreadsheet.gSheet.gForce;
            HttpResponse resp = gForce.sendRequest(new Map<String, String>{
                'method'   => 'PUT',
                'endpoint' => endpoint + queryParams,
                'body' => jsonBody
            });

            return (UpdateValuesResponse) JSON.deserialize(
                gForce.handleResponse(resp), UpdateValuesResponse.class);
        }

    }

    public class UpdateValuesResponse {
        private String     spreadsheetId;
        private Integer    updatedCells;
        private Integer    updatedColumns;
        private ValueRange updatedData;
        private String     updatedRange;
        private Integer    updatedRows;

        public String getSpreadsheetId() {
            return spreadsheetId;
        }

        public Integer getUpdatedCells() {
            return updatedCells;
        }

        public Integer getUpdatedColumns() {
            return updatedColumns;
        }

        public ValueRange getUpdatedData() {
            return updatedData;
        }

        public String getUpdatedRange() {
            return updatedRange;
        }

        public Integer getUpdatedRows() {
            return updatedRows;
        }

        public UpdateValuesResponse setSpreadsheetId(String spreadsheetId) {
            this.spreadsheetId = spreadsheetId;
            return this;
        }

        public UpdateValuesResponse setUpdatedCells(Integer updatedCells) {
            this.updatedCells = updatedCells;
            return this;
        }

        public UpdateValuesResponse setUpdatedColumns(Integer updatedColumns) {
            this.updatedColumns = updatedColumns;
            return this;
        }

        public UpdateValuesResponse setUpdatedData(ValueRange updatedData) {
            this.updatedData = updatedData;
            return this;
        }

        public UpdateValuesResponse setUpdatedRange(String updatedRange) {
            this.updatedRange = updatedRange;
            return this;
        }

        public UpdateValuesResponse setUpdatedRows(Integer updatedRows) {
            this.updatedRows = updatedRows;
            return this;
        }
    }

    public class ValueRange {
        private String range;
        private String majorDimension;
        private List<List<String>> values;

        public String getMajorDimension() {
            return majorDimension;
        }

        public String getRange() {
            return range;
        }

        public List<List<String>> getValues() {
            return values;
        }

        public ValueRange setMajorDimension(String majorDimension) {
            this.majorDimension = majorDimension;
            return this;
        }

        public ValueRange setRange(String range) {
            this.range = range;
            return this;
        }

        public ValueRange setValues(List<List<String>> values) {
            this.values = values;
            return this;
        }
    }

    private String appendParam(String queryParams, String key, String value) {

        if (String.isEmpty(queryParams)) {
            queryParams = '?' + key + '=' + value;
        } else {
            queryParams += '&' + key + '=' + value;
        }

        return queryParams;
    }

    public Spreadsheets spreadsheets() {
        return new Spreadsheets(this);
    }
}