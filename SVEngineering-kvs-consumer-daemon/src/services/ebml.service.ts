import { logger } from './../logger';

export interface IParsedFragment {
  fragmentNumber: string;
  producerTimestamp?: Date;
  continuationToken?: string;
  payload: any;
}

// only read up to 2mb of a chunk looking for Kinesis tags
const MAX_BUFFER_READ = 2048;

// need control characters here, but likely nowhere else
/* eslint no-control-regex: "off" */

const parseKinesisTags = (buffer: Uint8Array): string[] => {
  const parse = (content: string): string[] => [
    /AWS_KINESISVIDEO_FRAGMENT_NUMBERD.\u0010\u0000\u0000\/(.*?)g.\u0010/,
    /AWS_KINESISVIDEO_PRODUCER_TIMESTAMPD.\u0010\u0000\u0000.(.*?)\u001fC/,
    /AWS_KINESISVIDEO_CONTINUATION_TOKEND.\u0010\u0000\u0000.(.*?)\u001fC/
  ].map(pattern => (content.match(pattern) || [null, null])[1] || null);

  let _buffer = "";
  let lastParse = [];

  // stream only what we need from the buffer since it can be potentially huge and cause Buffer errors 
  // when attempting to slice/convert
  for (const c of buffer) {
    _buffer += String.fromCharCode(c);

    // check every 1mb (tweak?)
    if (!(_buffer.length % 1024)) {
      lastParse = parse(_buffer).filter(v => !!v);

      // if we have all 3 tags, or we've reached the max (short stream) we're good
      if (lastParse.length === 3 || _buffer.length >= MAX_BUFFER_READ) break;
    }
  }

  return lastParse;
};

export const decode = (buffer: Uint8Array): IParsedFragment => {

  logger.info("Decoding Payload ...");

  const [
    fragmentNumber,
    producerTimestamp,
    continuationToken
  ] = parseKinesisTags(buffer);

  logger.info(fragmentNumber ? `EBML Fragment processed: ${fragmentNumber}` : `No fragments found in stream ...`);

  return {
    fragmentNumber,
    producerTimestamp: new Date(producerTimestamp ? parseInt(producerTimestamp, 10) * 1000 : Date.now()),
    continuationToken,
    payload: buffer
  };
};