# Stage 1: Build
FROM python:3.11-slim AS build
WORKDIR /app
COPY . .

RUN mkdir /build && \
    cp -r app /build && \
    cp -r tests /build && \
    cp requirements.txt /build

# Stage 2: Test
FROM python:3.11-slim AS test
WORKDIR /test
COPY --from=build /build /test
RUN pip install -r requirements.txt

CMD ["python", "-m", "unittest", "discover", "-s", "tests"]
