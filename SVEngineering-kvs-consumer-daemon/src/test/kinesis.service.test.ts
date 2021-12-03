import { take } from 'rxjs/operators';
import "./testbed";
import { KinesisService } from '../services/kinesis.service';

declare const global;

describe("Kinesis Integration", () => {
  const svc = new KinesisService(global.streamName);

  it('Should obtain HLS Url from Stream Name', (done) => {
    svc.mediaEndpoint$.pipe(
      take(1),
    ).toPromise().then((endpoint) => {
      expect(endpoint).toBeTruthy();
      done();
    });
  });
});

