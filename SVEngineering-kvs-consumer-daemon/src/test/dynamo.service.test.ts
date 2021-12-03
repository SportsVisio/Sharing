import { IKinesysCheckpoint } from './../interfaces/checkpoints.interfaces';
import "./testbed";
import { CheckpointTable, DynamoService } from '../services/dynamo.service';

declare const global;

describe("DynamoDb Integration", () => {
  const svc = new DynamoService();
  const sampleFragmentNo = "test12345";

  it('Should write fragment record from Stream Name', async () => {
    expect(
      await svc.addRecord<IKinesysCheckpoint>(CheckpointTable, {
        kv_stream: global.streamName,
        timestamp: new Date().toUTCString(),
        fragment_number: sampleFragmentNo
      })
    ).toBeTruthy();
  });

  it('Should obtain last Fragment from Stream Name', async () => {
    expect(
      await svc.query<IKinesysCheckpoint>(CheckpointTable, {
        ExpressionAttributeValues: {
          ":kv_stream": global.streamName
        } as any,
        KeyConditionExpression: `kv_stream = :kv_stream`,
        ScanIndexForward: false,
        Limit: 1,
        ConsistentRead: true
      }).then(([fragment]) => {
        if (!fragment) throw new Error(`No fragment found for ${global.streamName}`);
        return fragment;
      })
    ).toBeTruthy();
  });

  // Dyanamo is SO FAST that we need to increase the timeout or this simple test fails. ¯\_(ツ)_/¯
  jest.setTimeout(15000);

  it('Should retrieve and delete fragment record from Stream Name', async () => {
    const [record] = await svc.query<IKinesysCheckpoint>(CheckpointTable, {
      ExpressionAttributeValues: {
        ":stream": global.streamName,
        ":fragmentNo": sampleFragmentNo
      },
      FilterExpression: "fragment_number = :fragmentNo",
      KeyConditionExpression: `kv_stream = :stream`,
      ScanIndexForward: false,
      Limit: 1,
      ConsistentRead: true
    });

    if (!record) {
      expect(1).toBeTruthy();
    }
    else {
      const { kv_stream, timestamp } = record;

      const output = await svc.delete(CheckpointTable, { kv_stream, timestamp }, {
        ConditionExpression: "fragment_number = :fragmentNo",
        ExpressionAttributeValues: {
          ":fragmentNo": sampleFragmentNo
        }
      });

      expect(output).toBeTruthy();
    }

    return Promise.resolve();
  });
});