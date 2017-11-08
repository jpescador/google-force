@isTest
public class GoogleMockResponse implements HttpCalloutMock {

    private Integer code;
    private String status;
    private String body;
    private Map<String, String> responseHeaders;

    public GoogleMockResponse(Integer code, String status, String body,
        Map<String, String> responseHeaders) {

        this.code = code;
        this.status = status;
        this.body = body;

        if (responseHeaders == null) {
            this.responseHeaders = new Map<String, String>();
        } else {
            this.responseHeaders = responseHeaders;
        }
    }

    public HTTPResponse respond(HTTPRequest req) {

        HttpResponse res = new HttpResponse();
        for (String key : responseHeaders.keySet()) {
            res.setHeader(key, responseHeaders.get(key));
        }

        res.setBody(body);
        res.setStatusCode(code);
        res.setStatus(status);

        return res;
    }
}