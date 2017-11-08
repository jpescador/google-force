public class GoogleDrive {
    private static final String rootUrl = 'https://www.googleapis.com/drive/v3/files';
    private GoogleForce gForce;

    public GoogleDrive(GoogleForce gForce) {
        this.gForce = gForce;
    }

    public class File {
        private String id;
        private String name;

        public String getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public File setId(String id) {
            this.id = id;
            return this;
        }

        public File setName(String name) {
            this.name = name;
            return this;
        }
    }

    public class FileList {
        private List<File> files;
        private Boolean incompleteSearch;
        private String kind;
        private String nextPageToken;

        public List<File> getFiles() {
            return files;
        }

        public Boolean getIncompleteSearch() {
            return incompleteSearch;
        }

        public String getKind() {
            return kind;
        }

        public String getNextPageToken() {
            return nextPageToken;
        }

        public FileList setFiles(List<File> files) {
            this.files = files;
            return this;
        }

        public FileList setIncompleteSearch(Boolean incompleteSearch) {
            this.incompleteSearch = incompleteSearch;
            return this;
        }

        public FileList setKind(String kind) {
            this.kind = kind;
            return this;
        }

        public FileList setNextPageToken(String nextPageToken) {
            this.nextPageToken = nextPageToken;
            return this;
        }
    }

    public class Files {
        private GoogleDrive gDrive;

        public Files(GoogleDrive gDrive) {
            this.gDrive = gDrive;
        }

        public Copy copy(String fileId, File content) {
           return new Copy(this, fileId, content);
        }

        public DeleteFile deleteFile(String fileId) {
            return new DeleteFile(this, fileId);
        }

        public ListFiles listFiles() {
            return new ListFiles(this);
        }
    }

    public class Copy {

        private File content;
        private String fileId;
        private Files gFiles;

        public Copy(Files gFiles, String fileId, File content) {
            this.content = content;
            this.fileId = fileId;
            this.gFiles = gFiles;
        }

        public File execute() {
            String endpoint = GoogleDrive.rootUrl + '/' + fileId + '/copy';
            String jsonBody = JSON.serialize(content, true);

            GoogleForce gForce = gFiles.gDrive.gForce;
            HttpResponse resp = gForce.sendRequest(new Map<String, String>{
                'method'   => 'GET',
                'endpoint' => GoogleDrive.rootUrl,
                'body' => jsonBody
            });

            return (File) JSON.deserialize(
                gForce.handleResponse(resp), File.class);

        }
    }

    public class DeleteFile {

        private String fileId;
        private Files gFiles;

        public DeleteFile(Files gFiles, String fileId) {
            this.fileId = fileId;
            this.gFiles = gFiles;
        }

        public Boolean execute() {
            String endpoint = GoogleDrive.rootUrl + '/' + fileId;

            GoogleForce gForce = gFiles.gDrive.gForce;
            HttpResponse resp = gForce.sendRequest(new Map<String, String>{
                'method'   => 'DELETE',
                'endpoint' => endpoint
            });

            gForce.handleResponse(resp);
            return true;
        }
    }

    public class ListFiles {

        private Files gFiles;

        public ListFiles(Files gFiles) {
            this.gFiles = gFiles;
        }

        public FileList execute() {
            GoogleForce gForce = gFiles.gDrive.gForce;
            HttpResponse resp = gForce.sendRequest(new Map<String, String>{
                'method'   => 'GET',
                'endpoint' => GoogleDrive.rootUrl
            });

            return (FileList) JSON.deserialize(
                gForce.handleResponse(resp), FileList.class);

        }
    }

    public Files files() {
       return new Files(this);
    }
}