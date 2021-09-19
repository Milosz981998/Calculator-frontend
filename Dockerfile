FROM node:lts-alpine as front

# install simple http server for serving static content
RUN npm install -g @vue/cli

# make the 'app' folder the current working directory
WORKDIR /app

# Add necessary files to app
ENV PATH ./:/app/:./node_modules/.bin:$PATH
ENV NODE_ENV=development

# copy both 'package.json' and 'package-lock.json' (if available)
COPY package.json /app/package.json
COPY package-lock.json /app/package.lock.json

# install project dependencies
RUN npm install --silent

# copy project files and folders to the current working directory (i.e. 'app' folder)

COPY ./ .

EXPOSE 8080
CMD ["npm", "run", "serve"]