import "./testbed";
import { S3Service } from "../services/s3.service";

declare const global;

const mockFragment = "jest-test-fragment";

describe("S3 Fragment Writer Integration", () => {
  const svc = new S3Service(global.streamName);

  it('Should write fragment to Stream Bucket', async () => {
    expect(
      await svc.writeFragment({
        fragmentNumber: mockFragment,
        payload: "12345",

      })
    ).toBeTruthy();
  });

  it('Should delete mock fragment file', async () => {
    expect(
      await svc.writeFragment({
        fragmentNumber: mockFragment,
        payload: "12345",

      })
    ).toBeTruthy();
  });
});