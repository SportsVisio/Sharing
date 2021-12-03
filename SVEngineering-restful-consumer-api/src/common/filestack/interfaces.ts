export interface IFilestackUploadResponse {
  _file: {
    name: string;
    size: number;
    type: string;
    slice: () => any;
  };
  _sanitizeOptions: any;
  status: string;
  handle: string;
  url: string;
  container: string;
  key: string;
  uploadTags: any[];
  workflows: any[];
}