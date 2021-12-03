FROM node:12

COPY ./dist ./dist
COPY ./.env.* ./
COPY ./package.json ./
#COPY ./node_modules/ ./node_modules/

ARG environment
ENV NODE_ENV $environment

# Install these in the image so FFMpeg installer can run on the image
RUN npm install -g node-pre-gyp
RUN npm install
#RUN npm run build

ENV PORT 3000

CMD node dist/src/main